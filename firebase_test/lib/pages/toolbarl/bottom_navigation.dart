import 'dart:js';

import 'package:firebase_test/models/entities/toolbar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavigation extends HookConsumerWidget {
  final Widget child;
  BottomNavigation({required this.child, super.key});

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
            label: 'Home',
          ),

          // Calendar
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),

          // Setting
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
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
        return 1;

      case '/settings':
        return 2;

      default:
        return 0;
    }
  }
}
