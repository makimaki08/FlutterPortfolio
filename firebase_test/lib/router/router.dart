import 'package:firebase_test/pages/04_calendar/calendar_page.dart';
import 'package:firebase_test/pages/02_login/login_page.dart';
import 'package:firebase_test/pages/01_registration/registration_page.dart';
import 'package:firebase_test/pages/03_home/home_page.dart';
import 'package:firebase_test/pages/05_settings/settings_page.dart';
import 'package:firebase_test/pages/99_toolbarl/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

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

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return BottomNavigation(child: child);
      },
      routes: [
        // home
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

        // Calendar
        GoRoute(
          path: '/calendar',
          name: 'calendar',
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const CalendarPage(),
            );
          },
        ),

        // Settings
        GoRoute(
          path: '/settings',
          name: 'settings',
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const SettingsPage(),
            );
          },
        ),
      ],
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
