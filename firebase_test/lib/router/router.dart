import 'package:firebase_test/pages/login_page.dart';
import 'package:firebase_test/pages/registration_page.dart';
import 'package:firebase_test/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  // アプリ初回起動時
  initialLocation: '/',

  // path
  routes: [
    // ログインページ
    GoRoute(
      path: '/',
      name: 'login',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const LoginPage(),
        );
      },
    ),

    // 新規登録ページ
    GoRoute(
      path: '/registration',
      name: 'registration',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const RegistrationPage(),
        );
      },
    ),

    // トップページ
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: HomePage(),
        );
      },
    ),
  ],

  // 遷移先がなくエラーになった場合
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
