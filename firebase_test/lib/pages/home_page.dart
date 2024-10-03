import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  HomePage({super.key});

  // ここでログイン中userの情報取得
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Home Page'),
              const Gap(20),
              ElevatedButton(
                child: const Text('load'),
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
