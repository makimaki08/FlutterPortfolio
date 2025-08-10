import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final accountInfoEditControllerProvider =
    Provider<AccountInfoEditController>((ref) => AccountInfoEditController());

class AccountInfoEditController {
  /// メールアドレス・パスワード更新
  Future<String?> updateEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return 'ユーザー情報が取得できません';

    try {
      if (email.isNotEmpty && email != user.email) {
        await user.updateEmail(email);
      }
      if (password.isNotEmpty) {
        await user.updatePassword(password);
      }
      return null; // 成功時はnull
    } on FirebaseAuthException catch (e) {
      return '更新エラー: ${e.message}';
    }
  }

  /// アカウント削除（要再認証）
  Future<String?> deleteAccount({
    String? email, // 省略可: 未指定なら currentUser.email を使用
    required String password,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return 'ユーザー情報が取得できません';

    final reauthEmail = email ?? user.email;
    if (reauthEmail == null || reauthEmail.isEmpty) {
      return 'メールアドレスを取得できませんでした。';
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: reauthEmail,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      // Firestore 等のユーザーデータ削除が必要ならここで実施
      // await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

      await user.delete();
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
        case 'invalid-credential':
          return 'パスワードが正しくありません。';
        case 'user-mismatch':
        case 'user-not-found':
          return 'ユーザー情報を確認できません。';
        case 'requires-recent-login':
          return '再認証が必要です。再度ログインしてからお試しください。';
        default:
          return '削除エラー: ${e.message}';
      }
    } catch (_) {
      return '予期せぬエラーが発生しました';
    }
  }
}
