import 'package:firebase_test/models/entities/toolbar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavigation extends HookConsumerWidget {
  const BottomNavigation({
    required this.currentTab,
    required this.onSelectTab,
    super.key,
  });

  /// 選択タブ
  final TabItem currentTab;

  /// タブ選択トリガー
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      currentIndex: TabItem.values.indexOf(currentTab),
      type: BottomNavigationBarType.fixed,
      items: TabItem.values.map((e) => e.navigationItem).toList(),
      onTap: (index) => onSelectTab(TabItem.values[index]),
    );
  }
}

/// [TabItem]に対応する[BottomNavigationBarItem]を返す関数
extension _BottomNavigationBarItemExt on TabItem {
  BottomNavigationBarItem get navigationItem => () {
        final String label;
        final IconData iconData;

        switch (this) {
          case TabItem.home:
            label = 'home';
            iconData = Icons.home;
            break;
        }
        return BottomNavigationBarItem(icon: Icon(iconData), label: label);
      }();
}
