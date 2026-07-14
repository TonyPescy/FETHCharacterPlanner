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
    background: Color(0xFF1A1028), // darkest purple
    surface: Color(0xFF2A1745),    // Dark purple
    primary: Color(0xFF6B4FA3),    // Mid purple
    secondary: Color.fromARGB(255, 68, 49, 110),  // Deep purple - Darker than primary
    accent: Color(0xFFE5B84B),     // Golden color
    text: Color(0xFFF8F4FF),       // Lightest color for text on darker background
    icon: Color.fromARGB(255, 207, 189, 236),       // Light Color to show icons well
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

  static const fodlanWar = AppThemeColors(
  background: Color(0xFF120B1F),
  surface: Color(0xFF211334),
  primary: Color(0xFF4B2E83),
  secondary: Color(0xFFA98EDB),
  accent: Color(0xFFC9A227),
  text: Color(0xFFF5EFFF),
  icon: Color(0xFFBFA8E6),
);

  // Add 4–5 more themes...

  // IDs used to track user theme upon reloading the app
  static const Map<String, AppThemeColors> themes = {
    'Royal Purple': royalPurple,
    'Ocean': ocean,
    'Forest': forest,
    'Fodlan War': fodlanWar
  };
}
// AppThemes End

// Theme manager for tracking user theme upon reloading and changing it
class ThemeManager extends ChangeNotifier {
  AppThemeColors currentTheme = AppThemes.royalPurple;

  static const _themeKey = 'selectedTheme';

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final themeName = prefs.getString(_themeKey) ?? 'Royal Purple';

    currentTheme = AppThemes.themes[themeName] ?? AppThemes.royalPurple;

    notifyListeners();
  }

  Future<void> setTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();

    currentTheme = AppThemes.themes[themeName] ?? AppThemes.royalPurple;

    await prefs.setString(_themeKey, themeName);

    notifyListeners();
  }

  Map<String, AppThemeColors> getThemes() {
    return AppThemes.themes;
  }

}
// ThemeManager End

// CODE BELOW is used to change the theme of the app
//await ThemeManager.setTheme('ocean');
//setState(() {});

// Appsizes start
// Controls sizes for app
class AppSizes {
  // Topbar height as percentage of screen height
  static double topBarHeight(BuildContext context) => (MediaQuery.of(context).size.height * 0.10).clamp(56.0, 150.0);  // 8% of screen height - clamped to avoid massive topbars on larger screens

  // Icon size inside topbar
  static double topBarIcon(BuildContext context) => topBarHeight(context) * 1;  // 100% of topbar height to avoid it looking like a blob

  // Settings icon size
  static double settingsIcon(BuildContext context) => topBarHeight(context) * 0.5;  // 50% of topbar height
}
// AppSizes End

// FontSize start
// Used to scale font sizes for differnt devices used
class FontSize {
  static double scale(
    BuildContext context,
    double size, {
    double min = 8,
    double max = 48,
  }) {
    final width = MediaQuery.of(context).size.width;

    const baseWidth = 375.0;

    final scaled = size * (width / baseWidth);

    return scaled.clamp(min, max);
  }
}
// Fontsize End

// App text sizing presets
class AppTextSizes {
  static double title(BuildContext context) => FontSize.scale(context, 20, max: 42);

  static double heading(BuildContext context) => FontSize.scale(context, 16, max: 30);

  static double body(BuildContext context) => FontSize.scale(context, 12, max: 22);

  static double caption(BuildContext context) => FontSize.scale(context, 8, max: 16);
}