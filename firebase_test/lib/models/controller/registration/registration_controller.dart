import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/models/controller/registration/registration_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/loading.dart';

final registrationProvider =
    StateNotifierProvider<RegistrationController, RegistrationState>(
        RegistrationController.new);

class RegistrationController extends StateNotifier<RegistrationState> {
  RegistrationController(this._ref) : super(const RegistrationState());
  final Ref _ref;

  /// 新規登録
  Future<void> register(String email, String password) async {
    await Loading.show();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
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
