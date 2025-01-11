/// BottomNavigationで利用するタブの要素
library;

enum TabItem {
  /// home
  home('/home');

  const TabItem(this.path);

  final String path;
}
