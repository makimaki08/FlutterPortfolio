import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/models/controller/registration/registration_state.dart';
import 'package:firebase_test/repositories/secure_storage_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../widgets/loading.dart';

final registrationProvider =
    StateNotifierProvider<RegistrationController, RegistrationState>(
        RegistrationController.new);

class RegistrationController extends StateNotifier<RegistrationState> {
  RegistrationController(this._ref) : super(const RegistrationState());
  final Ref _ref;

  /* --- コントローラー --- */
  /// ユーザーID
  TextEditingController inputUserIdController = TextEditingController();

  /// パスワード
  TextEditingController inputPasswordController = TextEditingController();

  /// 名前
  TextEditingController inputNameController = TextEditingController();

  /* --- メソッド --- */
  /// フォームリセット
  Future<void> resetForm() async {
    inputUserIdController = TextEditingController();
    inputPasswordController = TextEditingController();
    inputNameController = TextEditingController();
  }

  /// 新規登録
  Future<void> register() async {
    await Loading.show();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: inputUserIdController.text,
        password: inputPasswordController.text,
      );

      if (credential.user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'The user does not exist.',
        );
      }

      state = state.copyWith(
        isAuth: true,
        uid: credential.user!.uid,
      );
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      // 例外を再スローする
      rethrow;
    } finally {
      await Loading.dismiss();
    }
  }
}
