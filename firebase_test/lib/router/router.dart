import 'package:firebase_test/pages/004_calendar/001_calendar/calendar_page.dart';
import 'package:firebase_test/pages/001_login/login_page.dart';
import 'package:firebase_test/pages/002_registration/registration_page.dart';
import 'package:firebase_test/pages/003_home/home_page.dart';
import 'package:firebase_test/pages/004_calendar/002_detail/calendar_detail_page.dart';
import 'package:firebase_test/pages/005_settings/001_settings/settings_page.dart';
import 'package:firebase_test/pages/005_settings/002_account_info_edit/account_info_edit.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:firebase_test/pages/005_settings/003_children_info_edit/children_info_edit_page.dart';
import 'package:firebase_test/pages/999_other/toolbarl/bottom_navigation.dart';
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
          routes: [
            GoRoute(
              path: 'detail',
              name: 'detail',
              pageBuilder: (context, state) {
                final extra = state.extra as CalendarEvent;
                return MaterialPage(
                  child: CalendarDetailPage(event: extra),
                );
              },
            ),
          ],
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
          routes: [
            GoRoute(
              path: 'mail_password_edit',
              name: 'mail_password_edit',
              pageBuilder: (context, state) {
                return const MaterialPage(
                  child: MailPasswordEditPage(),
                );
              },
            ),
            GoRoute(
              path: 'account_info_edit',
              name: 'account_info_edit',
              pageBuilder: (context, state) {
                return const MaterialPage(
                  child: ChildrenInfoEditPage(),
                );
              },
            ),
          ],
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
