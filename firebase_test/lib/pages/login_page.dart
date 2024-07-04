import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/models/controller/login/login_state.dart';
import 'package:firebase_test/repositories/secure_storage_repository.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../models/controller/login/login_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ログインFormの入力情報を管理
    final loginController = ref.watch(loginProvider.notifier);

    // ログインの状態を監視
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Firebase_Auto_app')),
      body: SafeArea(
        child: Center(
          child: Card(
            child: Container(
              constraints: BoxConstraints.loose(const Size(600, 600)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // メールアドレス入力
                  TextFormField(
                    controller: loginController.inputUserIdController,
                    decoration: const InputDecoration(labelText: 'メールアドレス'),
                    textInputAction: TextInputAction.next,
                  ),
                  const Gap(8),

                  // パスワード入力
                  TextFormField(
                    controller: loginController.inputPasswordController,
                    decoration: InputDecoration(labelText: 'パスワード'),
                    obscureText: true,
                  ),
                  const Gap(16),

                  // ログインボタン
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('ログイン'),
                      onPressed: () => _handleLogin(
                        context,
                        loginController,
                        loginState,
                      ),
                    ),
                  ),
                  const Gap(16),

                  // 新規登録
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('新規登録'),
                      onPressed: () => context.go('/registration'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ログイン処理
  void _handleLogin(
    BuildContext context,
    LoginController loginController,
    LoginState loginState,
  ) async {
    try {
      await loginController.login();
      if (loginState.isAuth) {
        context.go('/home');
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('エラー'),
              content: const Text('ログインに失敗しました。\nもう一度お試しください。'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                )
              ],
            );
          },
        );
      }
    } catch (e) {
      //
    }
  }
}
