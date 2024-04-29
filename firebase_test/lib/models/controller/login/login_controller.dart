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
    try {
      await Loading.show();

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'test@gmail.com',
        // email: inputUserIdController.text,
        password: 'test01',
      );

      // state = state.copyWith(
      //   isAuth: true,
      //   token: credential.credential!.token.toString(),
      // );

      // SecureStrageに、UserID保存
      final container = ProviderContainer();
      final secureStorageRepository =
          container.read(secureStorageRepositoryProvider);

      // userIDを保存する
      // await secureStorageRepository.saveUserId(loginRequest.userId);
    }

    // エラー処理
    on FirebaseAuthException catch (e) {
      print(e.message);
    } finally {
      await Loading.dismiss();
    }
  }
}
