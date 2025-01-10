import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LogoutModal {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ログアウトしますか？'),
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
