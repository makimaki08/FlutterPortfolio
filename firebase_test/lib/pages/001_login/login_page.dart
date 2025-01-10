import 'package:firebase_test/models/controller/login/login_state.dart';
import 'package:firebase_test/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../models/controller/login/login_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* --- コントローラー --- */
    /// ユーザーID
    TextEditingController inputEmailController = TextEditingController();

    /// パスワード
    TextEditingController inputPasswordController = TextEditingController();

    // ログインの状態を監視
    final loginState = ref.watch(loginProvider);

    final loginController = ref.watch(loginProvider.notifier);

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
                    controller: inputEmailController,
                    decoration: const InputDecoration(labelText: 'メールアドレス'),
                    textInputAction: TextInputAction.next,
                    validator: ValidateText().emailValidator,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                  ),
                  const Gap(8),

                  // パスワード入力
                  TextFormField(
                    controller: inputPasswordController,
                    decoration: const InputDecoration(labelText: 'パスワード'),
                    obscureText: true,
                    validator: ValidateText().passwordValidator,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                  ),
                  const Gap(16),

                  // ログインボタン
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('ログイン'),
                      // TODO: 固定値でログインさせているため、コントローラーから取得した値でログインできるように変更させる
                      onPressed: () => _handleLogin(
                        context,
                        loginState,
                        loginController,
                        // inputEmailController.text,
                        "login_address@test.com",
                        // inputPasswordController.text,
                        "Password1234",
                      ),
                    ),
                  ),
                  const Gap(16),

                  // 新規登録
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('新規登録'),
                      onPressed: () => context.push('/registration'),
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
    LoginState loginState,
    LoginController loginController,
    String email,
    String password,
  ) async {
    try {
      await loginController.login(email, password);
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
