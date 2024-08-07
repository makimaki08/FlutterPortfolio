import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/controller/registration/registration_controller.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationController = ref.watch(registrationProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('新規登録ページ')),
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
                    controller: registrationController.inputUserIdController,
                    decoration: const InputDecoration(labelText: 'メールアドレス'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 8),

                  // パスワード入力
                  TextFormField(
                    controller: registrationController.inputPasswordController,
                    decoration: const InputDecoration(labelText: 'パスワード'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),

                  // 新規登録
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('新規登録'),
                      onPressed: () async {
                        if (registrationController.isRegistered == false) {
                          await registrationController.register();
                          context.go('/home');
                        } else {
                          // 既に登録済みの場合はダイアログを表示
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('エラー'),
                              content: const Text(
                                  'このメールアドレスは既に登録されています。\nログイン画面からログインしてください。'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
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
}
