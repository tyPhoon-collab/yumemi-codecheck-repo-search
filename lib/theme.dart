import 'package:flutter/material.dart';

const seedColor = Colors.purple;

final theme = _buildTheme(
  ThemeData.light(useMaterial3: true),
  ColorScheme.fromSeed(seedColor: seedColor),
);

final darkTheme = _buildTheme(
  ThemeData.dark(useMaterial3: true),
  ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
  ),
);

ThemeData _buildTheme(ThemeData base, ColorScheme colorScheme) {
  return base.copyWith(
    colorScheme: colorScheme,
    // もし全体で変えるテーマがあればここに書くことで、ダークモードとともに適用できる
    // textTheme: base.textTheme.copyWith(...)  // 例）フォントを変える時
    snackBarTheme: base.snackBarTheme.copyWith(
      behavior: SnackBarBehavior.floating,
    ),
  );
}
