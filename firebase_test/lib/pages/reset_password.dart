import 'package:firebase_test/models/controller/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ResetPassword extends ConsumerWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginController = ref.watch(loginProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('パスワードリセットページ')),
      body: SafeArea(
        child: Center(
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

                // ElevatedButton(
                //   onPressed: onPressed,
                //   child: const Text("パスワードリセット"),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
