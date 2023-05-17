import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ColorScheme lightColorScheme(ColorScheme? lightDynamic) {
    return lightDynamic?.harmonized() ??
        ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).harmonized();
  }

  static ColorScheme darkColorScheme(ColorScheme? darkDynamic) {
    return darkDynamic?.harmonized() ??
        ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ).harmonized();
  }

  static ThemeData lightTheme(ColorScheme lightColorScheme) {
    return ThemeData(
      colorScheme: lightColorScheme,
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
    ).copyWith(
        dividerTheme:
            DividerThemeData(color: lightColorScheme.onSurface.withAlpha(45)),
        iconTheme: IconThemeData(color: lightColorScheme.secondary));
  }

  static ThemeData darkTheme(ColorScheme darkColorScheme) {
    return ThemeData(
      colorScheme: darkColorScheme,
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
    ).copyWith(
      dividerTheme:
          DividerThemeData(color: darkColorScheme.onSurface.withAlpha(45)),
      iconTheme: IconThemeData(color: darkColorScheme.secondary),
    );
  }
}
