import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/models/controller/login/login_state.dart';
import 'package:firebase_test/repositories/secure_storage_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../widgets/loading.dart';

final loginProvider =
    StateNotifierProvider<LoginController, LoginState>(LoginController.new);

class LoginController extends StateNotifier<LoginState> {
  LoginController(this._ref) : super(const LoginState());
  final Ref _ref;

  /* --- コントローラー --- */
  /// ユーザーID
  TextEditingController inputUserIdController = TextEditingController();

  /// パスワード
  TextEditingController inputPasswordController = TextEditingController();

  /* --- メソッド --- */
  /// フォームリセット
  Future<void> resetForm() async {
    inputUserIdController = TextEditingController();
    inputPasswordController = TextEditingController();
  }

  /// ログイン
  Future<void> login() async {
    await Loading.show();

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
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
