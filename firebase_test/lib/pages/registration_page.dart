import 'package:firebase_test/validator/validator.dart';
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
                    validator: ValidateText().emailValidator,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                  ),
                  const SizedBox(height: 8),

                  // パスワード入力
                  TextFormField(
                    controller: registrationController.inputPasswordController,
                    decoration: const InputDecoration(labelText: 'パスワード'),
                    obscureText: true,
                    validator: ValidateText().passwordValidator,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                  ),
                  const SizedBox(height: 16),

                  // 新規登録
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('新規登録'),
                      onPressed: () async {
                        await registrationController.register();
                        context.go('/home');
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
