import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/repositories/secure_storage_repository.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../models/controller/login/login_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ログインFormの入力情報を管理
    final loginController = ref.watch(loginProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Firebase_Auto_app')),
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
                    controller: loginController.inputUserIdController,
                    decoration: InputDecoration(labelText: 'メールアドレス'),
                    textInputAction: TextInputAction.next,
                  ),
                  Gap(8),

                  // パスワード入力
                  TextFormField(
                    controller: loginController.inputPasswordController,
                    decoration: InputDecoration(labelText: 'パスワード'),
                    obscureText: true,
                  ),
                  Gap(16),

                  // ログインボタン
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('ログイン'),
                      onPressed: () async {
                        loginController.login();
                        context.go('/top');
                      },
                    ),
                  ),
                  Gap(16),

                  // 新規登録
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('新規登録'),
                      onPressed: () => context.go('/registration'),
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
