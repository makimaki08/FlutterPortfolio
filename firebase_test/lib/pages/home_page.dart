import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/repositories/secure_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  HomePage({super.key});

  // ここでログイン中userの情報取得
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Top Page'),
              Gap(20),
              ElevatedButton(
                child: Text('load'),
                onPressed: () => _isLogin(user),
              ),
              Text(user!.uid),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _isLogin(User? user) async {
  // ログイン中か確認するメソッド
  if (user != null && !user!.emailVerified) {
    await user!.sendEmailVerification();
  }
}
