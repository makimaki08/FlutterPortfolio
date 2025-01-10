import 'package:firebase_test/pages/005_settings/004_logout_modal/logout_modal.dart';
import 'package:firebase_test/pages/005_settings/005_delete_account_modal/delete_account_modal.dart';
import 'package:firebase_test/router/router.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => context.go('/settings/mail_password_edit'),
                child: const Text("アカウント情報変更"),
              ),
              const Gap(12),
              ElevatedButton(
                onPressed: () {},
                child: const Text("お子様情報変更"),
              ),
              const Gap(12),
              ElevatedButton(
                onPressed: () => LogoutModal.show(context),
                child: const Text("ログアウト"),
              ),
              const Gap(12),
              ElevatedButton(
                onPressed: () => DeleteAccountModal.show(context),
                child: const Text("退会"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
