import 'package:firebase_test/models/controller/account_info_edit/account_info_edit_controller.dart';
import 'package:firebase_test/models/controller/login/login_controller.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountModal {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final controller = ref.read(accountInfoEditControllerProvider);
            final loginState = ref.watch(loginProvider);
            final passwordController = TextEditingController();

            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: const Text('本当にアカウントを削除しますか？'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'アカウントを削除すると元に戻せません。',
                    style: TextStyle(color: AppColors.blue),
                  ),
                  const Gap(12),
                  Text(
                      '対象メールアドレス: ${loginState.email?.isNotEmpty == true ? loginState.email : "-"}'),
                  const Gap(12),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'アカウントのパスワード',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  child: const Text('キャンセル'),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  icon: const Icon(Icons.delete_forever),
                  label: const Text('はい、削除する'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    final password = passwordController.text.trim();
                    if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('パスワードを入力してください。')),
                      );
                      return;
                    }

                    final error = await controller.deleteAccount(
                      email: loginState.email,
                      password: password,
                    );

                    if (!context.mounted) return;
                    if (error == null) {
                      Navigator.of(context, rootNavigator: true).pop();

                      // 認証状態を初期化
                      ref.read(loginProvider.notifier).reset();

                      // ログイン画面へ
                      context.go('/');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
