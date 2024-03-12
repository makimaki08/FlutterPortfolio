import 'package:flutter/material.dart';

enum ThemeModeType { light, dark, system }

class ThemeModeNotifier extends ChangeNotifier {
  ThemeModeType _themeModeType = ThemeModeType.system;

  ThemeModeType get themeModeType => _themeModeType;

  set themeModeType(ThemeModeType mode) {
    _themeModeType = mode;
    notifyListeners();
  }
}
