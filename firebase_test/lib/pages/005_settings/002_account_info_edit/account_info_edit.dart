import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/models/controller/account_info_edit/account_info_edit_controller.dart';
import 'package:firebase_test/models/controller/login/login_controller.dart';
import 'package:firebase_test/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class MailPasswordEditPage extends ConsumerWidget {
  const MailPasswordEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);

    TextEditingController inputEmailController =
        TextEditingController(text: loginState.email);
    TextEditingController inputPasswordController =
        TextEditingController(text: '');

    // コントローラー取得
    final accountInfoEditController =
        ref.read(accountInfoEditControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('アカウント情報変更'), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.person,
                        size: 48, color: Colors.blueAccent),
                    const Gap(12),
                    Text(
                      'メールアドレス・パスワードの変更',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(8),
                    const Text(
                      'ご登録のメールアドレスとパスワードを変更できます。',
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(24),
                    TextFormField(
                      controller: inputEmailController,
                      decoration: const InputDecoration(
                        labelText: 'メールアドレス',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: ValidateText().emailValidator,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: inputPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'パスワード',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: ValidateText().passwordValidator,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                    ),
                    const Gap(32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save, color: Colors.white),
                        label: const Text('変更を保存'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          final error = await accountInfoEditController
                              .updateEmailAndPassword(
                            email: inputEmailController.text.trim(),
                            password: inputPasswordController.text.trim(),
                          );
                          if (error == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('更新が完了しました')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error)),
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
      ),
    );
  }
}
