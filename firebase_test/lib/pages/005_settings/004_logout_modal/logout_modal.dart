import 'package:firebase_test/models/controller/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LogoutModal {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final loginState = ref.watch(loginProvider);

            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              insetPadding: const EdgeInsets.symmetric(horizontal: 24),
              titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
              actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              title: const Row(
                children: [
                  Icon(Icons.logout, color: Colors.redAccent),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'ログアウトしますか？',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '現在の操作を終了してログイン画面に戻ります。',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Gap(16),
                ],
              ),
              actions: [
                OutlinedButton(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  child: const Text('キャンセル'),
                ),
                FilledButton.icon(
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text('ログアウト'),
                  onPressed: () async {
                    await ref.read(loginProvider.notifier).logout();

                    if (!context.mounted) return;
                    // ダイアログを閉じる
                    Navigator.of(context, rootNavigator: true).pop();
                    // ログイン画面へ
                    context.go('/login');
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
