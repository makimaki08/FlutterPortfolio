import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavigation extends HookConsumerWidget {
  final Widget child;
  const BottomNavigation({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        items: const <BottomNavigationBarItem>[
          // home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),

          // Calendar
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'カレンダー',
          ),

          // Setting
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/calendar');
              break;
            case 2:
              context.go('/settings');
              break;
          }
        },
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouterState routerState = GoRouterState.of(context);
    final String location = routerState.matchedLocation;

    switch (location) {
      case '/home':
        return 0;

      case '/calendar':
      case '/calendar/detail':
        return 1;

      case '/settings':
      case '/settings/mail_password_edit':
      case '/settings/account_info_edit':
        return 2;

      default:
        return 0;
    }
  }
}
