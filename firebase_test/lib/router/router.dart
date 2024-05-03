import 'package:firebase_test/pages/login_page.dart';
import 'package:firebase_test/pages/top_page.dart';
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

    // トップページ
    GoRoute(
      path: '/top',
      name: 'top',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: TopPage(),
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
