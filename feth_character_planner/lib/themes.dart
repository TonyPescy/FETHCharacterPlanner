import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// AppThemeColors Start
// Layouts the theme colors to be created later
class AppThemeColors {
  final Color background;
  final Color surface;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color text;
  final Color icon;

  const AppThemeColors({
    required this.background,
    required this.surface,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.text,
    required this.icon,
  });
}
// AppThemeColors End

// AppThemes Starts
// Creates the themes to be used for the app
class AppThemes {
  static const royalPurple = AppThemeColors(
    background: Color.fromRGBO(63, 28, 87, 0.85),
    surface: Color.fromARGB(255, 255, 0, 0),
    primary: Color.fromARGB(255, 200, 255, 0),
    secondary: Color.fromARGB(255, 0, 0, 0),
    accent: Color.fromRGBO(22, 49, 201, 1),
    text: Color.fromARGB(255, 58, 8, 8),
    icon: Colors.white70,
  );

  static const ocean = AppThemeColors(
    background: Color(0xFF0D3B66),
    surface: Color(0xFF145DA0),
    primary: Color(0xFF2E8BC0),
    secondary: Color(0xFFB1D4E0),
    accent: Color(0xFFF4D35E),
    text: Colors.white,
    icon: Colors.white70,
  );

  static const forest = AppThemeColors(
    background: Color(0xFF1B4332),
    surface: Color(0xFF2D6A4F),
    primary: Color(0xFF40916C),
    secondary: Color(0xFF74C69D),
    accent: Color(0xFFFFD166),
    text: Colors.white,
    icon: Colors.white70,
  );

  // Add 4–5 more themes...

  // IDs used to track user theme upon reloading the app
  static const Map<String, AppThemeColors> themes = {
    'royalPurple': royalPurple,
    'ocean': ocean,
    'forest': forest,
  };
}
// AppThemes End

// Theme manager for tracking user theme upon reloading and changing it
class ThemeManager extends ChangeNotifier {
  AppThemeColors currentTheme = AppThemes.royalPurple;

  static const _themeKey = 'selectedTheme';

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final themeName = prefs.getString(_themeKey) ?? 'royalPurple';

    currentTheme =
        AppThemes.themes[themeName] ?? AppThemes.royalPurple;

    notifyListeners();
  }

  Future<void> setTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();

    currentTheme =
        AppThemes.themes[themeName] ?? AppThemes.royalPurple;

    await prefs.setString(_themeKey, themeName);

    notifyListeners();
  }
}
// ThemeManager End

// CODE BELOW is used to change the theme of the app
//await ThemeManager.setTheme('ocean');
//setState(() {});
