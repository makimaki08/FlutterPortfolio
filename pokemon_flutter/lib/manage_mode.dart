import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ThemeModeを数値に変換
int modeToVal(ThemeMode mode) {
  switch(mode) {
    case ThemeMode.system:
      return 1;
    case ThemeMode.dark:
      return 2;
    case ThemeMode.light:
      return 3;
    default:
      return 0;
  }
}

// 数値をThemeModeに変換
ThemeMode valToMode(int val) {
  switch(val) {
    case 1:
      return ThemeMode.system;
    case 2:
      return ThemeMode.dark;
    case 3:
      return ThemeMode.light;
    default:
      return ThemeMode.system;
  }
}

// 引数に渡されたmodeを、数値としてprefに保存する
Future<void> saveThemeMode(ThemeMode mode) async {
  final pref = await SharedPreferences.getInstance();
  // theme_modeというKeyで、modeの値を渡す
  pref.setInt('theme_mode', modeToVal(mode));
}

//
Future<ThemeMode> loadThemeMode() async {
  final pref = await SharedPreferences.getInstance();
  // prefに保存したtheme_modeの値を呼び出し｜呼び出せなかったら0を設定
  final ret = valToMode(pref.getInt('theme_mode') ?? 0);
  return ret;
}

// 変更を通知する処理
class ThemeModeNotifier extends ChangeNotifier {
  late ThemeMode _themeMode;

  ThemeModeNotifier(SharedPreferences pref) {
    _init();
  }

  // _themeModeをmodeに設定 ※modeは引数として扱える
  ThemeMode get mode => _themeMode;

  void _init() async {
    _themeMode = await loadThemeMode();
    notifyListeners();
  }

  void update(ThemeMode nextMode) {
    _themeMode = nextMode;
    saveThemeMode(nextMode);
    notifyListeners();
  }
}