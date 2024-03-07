import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final ThemeData simpleLightTheme = ThemeData.from(colorScheme: const ColorScheme.light());
final ThemeData simpleDarkTheme = ThemeData.from(colorScheme: const ColorScheme.dark());

ThemeData get makoGreenTheme {
  const _primaryColor = Color(0xFF68D4C7);
  const _secondaryColor = Color(0xFF40CCBB);
  return ThemeData.from(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _primaryColor,
      secondary: _secondaryColor
    )
  ).copyWith(
    brightness: Brightness.dark,
    primaryColor: _secondaryColor,
    buttonTheme: const ButtonThemeData(
      buttonColor: _secondaryColor
    ),
    iconTheme: const IconThemeData(
      color: _primaryColor
    ),
    toggleableActiveColor: _primaryColor,
    cupertinoOverrideTheme: const CupertinoThemeData(
      textTheme: CupertinoTextThemeData(),
    )
  );
}

// If you change the order, the order in which it is displayed also changes
enum ExThemeMode {
  system,
  light,
  dark,
  makoGreen,
  darkGreen,
}

extension Extension on ExThemeMode {
  /// No duplicate/unchanged numbers
  int get id {
    switch (this) {
      case ExThemeMode.system:
        return 1000;
      case ExThemeMode.light:
        return 1001;
      case ExThemeMode.dark:
        return 1002;
      case ExThemeMode.darkGreen:
        return 1003;
      case ExThemeMode.makoGreen:
        return 1004;
    }
    return 0;
  }

  /// Display names
  String? get name {
    switch (this) {
      case ExThemeMode.system:
        return 'System';
      case ExThemeMode.light:
        return 'Lignt';
      case ExThemeMode.dark:
        return 'Dark';
      case ExThemeMode.darkGreen:
        return 'Dark Green';
      case ExThemeMode.makoGreen:
        return 'Mako';
    }
    return null;
  }

  /// Display descriptions
  String? get description {
    switch (this) {
      case ExThemeMode.system:
        return 'System setting';
      case ExThemeMode.light:
        return 'Default light theme';
      case ExThemeMode.dark:
        return 'Default dark theme';
      case ExThemeMode.darkGreen:
        return 'Green dark theme';
      case ExThemeMode.makoGreen:
        return 'Lifestream-inspired theme';
    }
    return null;
  }

  /// Themes icon
  IconData? get icon {
    switch (this) {
      case ExThemeMode.system:
        return Icons.settings;
      case ExThemeMode.light:
        return MdiIcons.weatherSunny;
      case ExThemeMode.dark:
        return MdiIcons.weatherNight;
      case ExThemeMode.darkGreen:
        return MdiIcons.tree;
      case ExThemeMode.makoGreen:
        return MdiIcons.sword;
    }
    return null;
  }

  /// Theme by ExThemeMode
  ThemeData? get themeData {
    switch (this) {
      case ExThemeMode.system:
        return simpleLightTheme;

      case ExThemeMode.light:
        return simpleLightTheme;

      case ExThemeMode.dark:
        return simpleDarkTheme;

      case ExThemeMode.darkGreen:
        return darkGreenTheme;

      case ExThemeMode.makoGreen:
        return makoGreenTheme;
    }
    return null;
  }

  /// Theme by ExThemeMode for Dark mode
  ThemeData? get darkThemeData {
    switch (this) {
      case ExThemeMode.system:
        return simpleDarkTheme;

      default:
        return null;
    }
  }
}