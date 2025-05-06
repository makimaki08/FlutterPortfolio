import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountModal {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('本当にアカウントを削除しますか？'),
          content: const Text(
            'アカウントを削除すると元に戻せません',
            style: TextStyle(color: AppColors.blue),
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  // TODO: ログアウト処理を追記
                  onPressed: () {},
                  child: const Text('はい'),
                ),
                const Gap(12),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('いいえ'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
