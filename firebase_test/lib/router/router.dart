import 'package:firebase_test/pages/auth_app_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  // アプリ初回起動時
  initialLocation: '/',

  // path
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const AuthAppPage(title: 'Firebase_Auto_app'),
        );
      },
    )
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
