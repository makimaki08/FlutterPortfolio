import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/models/controller/login/login_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/loading.dart';

final loginProvider =
    StateNotifierProvider<LoginController, LoginState>(LoginController.new);

class LoginController extends StateNotifier<LoginState> {
  LoginController(this._ref) : super(const LoginState());
  final Ref _ref;

  /// ログイン
  Future<void> login(String email, String password) async {
    await Loading.show();

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        // email: inputUserIdController.text,
        // password: inputPasswordController.text,

        // for Dev
        email: "test@test23156789.com",
        password: "Pass12345678901",
      );

      if (credential.user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'The user does not exist.',
        );
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_uid', state.uid);

      state = state.copyWith(
        isAuth: true,
        uid: credential.user!.uid,
        email: credential.user!.email ?? '',
      );
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
    } finally {
      await Loading.dismiss();
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } finally {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_uid');
      state = const LoginState(); // isAuth=false等の初期状態へ
    }
  }

  void reset() {
    state = const LoginState();
  }
}
