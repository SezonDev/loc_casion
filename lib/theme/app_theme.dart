import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // 🎨 COULEURS PRINCIPALES
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF0AE2D0),
      secondary: Color(0xFF0AE2D0),
      surface: Color(0xFF101010),
      background: Color(0xFF080A0A),
    ),

    // 📝 STYLE DES TEXTFIELDS
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF0AE2D0)),
        borderRadius: BorderRadius.circular(14),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF0AE2D0), width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
    ),

    // 🔘 STYLE DES BOUTONS
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0AE2D0),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF0AE2D0), width: 2),
        foregroundColor: const Color(0xFF0AE2D0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF0AE2D0),
      ),
    ),
  );
}
