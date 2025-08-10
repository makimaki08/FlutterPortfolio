import 'package:firebase_test/pages/005_settings/004_logout_modal/logout_modal.dart';
import 'package:firebase_test/pages/005_settings/005_delete_account_modal/delete_account_modal.dart';
import 'package:firebase_test/style/color/app_colors.dart';
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
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.person, color: AppColors.blue),
                    title: const Text("アカウント情報変更"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () => context.go('/settings/mail_password_edit'),
                  ),
                ),
                const Gap(12),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.child_care,
                        color: AppColors.burlywood),
                    title: const Text("お子様情報変更"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () => context.go('/settings/account_info_edit'),
                  ),
                ),
                const Gap(12),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading:
                        const Icon(Icons.logout, color: AppColors.darkgray),
                    title: const Text("ログアウト"),
                    onTap: () => LogoutModal.show(context),
                  ),
                ),
                const Gap(12),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.delete_forever,
                        color: Colors.redAccent),
                    title: const Text("退会"),
                    onTap: () => DeleteAccountModal.show(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
