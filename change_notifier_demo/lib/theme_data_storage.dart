import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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