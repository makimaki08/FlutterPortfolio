import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/models/controller/registration/registration_controller.dart';
import 'package:firebase_test/repositories/secure_storage_repository.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../models/controller/login/login_controller.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationController = ref.watch(registrationProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('新規登録ページ')),
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
                    decoration: InputDecoration(labelText: 'メールアドレス'),
                    textInputAction: TextInputAction.next,
                  ),
                  Gap(8),

                  // パスワード入力
                  TextFormField(
                    controller: registrationController.inputPasswordController,
                    decoration: InputDecoration(labelText: 'パスワード'),
                    obscureText: true,
                  ),
                  Gap(16),

                  // 新規登録
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('新規登録'),
                      onPressed: () async {
                        await registrationController.registration();
                        context.go('/top');
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
