import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../models/controller/login/login_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ログインFormの入力情報を管理
    final loginController = ref.watch(loginProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // メールアドレス入力
                TextFormField(
                  controller: loginController.inputUserIdController,
                  decoration: InputDecoration(labelText: 'ユーザーID'),
                  textInputAction: TextInputAction.next,
                ),

                // パスワード入力
                TextFormField(
                  controller: loginController.inputPasswordController,
                  decoration: InputDecoration(labelText: 'パスワード'),
                  obscureText: true,
                  onChanged: (String value) {},
                ),
                Gap(20),

                Container(
                  width: double.infinity,
                  // ユーザー登録ボタン
                  child: ElevatedButton(
                    child: Text('ログイン'),
                    onPressed: () async {
                      await ref.read(loginProvider.notifier).login().then((_) {
                        context.go('/top');
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
