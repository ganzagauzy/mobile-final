import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _currentTheme;
  final String key = "theme";
  SharedPreferences? _prefs;

  ThemeNotifier() : _currentTheme = primaryTheme {
    _loadFromPrefs();
  }

  ThemeData get currentTheme => _currentTheme;

  Future<void> toggleTheme() async {
    _currentTheme =
        (_currentTheme == secondaryTheme) ? primaryTheme : secondaryTheme;
    await _saveToPrefs(_currentTheme == secondaryTheme ? 'yellow' : 'black');
    notifyListeners();
  }

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> _loadFromPrefs() async {
    await _initPrefs();
    final themeStr = _prefs!.getString(key) ?? 'black';
    _currentTheme = (themeStr == 'yellow') ? primaryTheme : secondaryTheme;
    notifyListeners();
  }

  Future<void> _saveToPrefs(String themeStr) async {
    await _initPrefs();
    await _prefs!.setString(key, themeStr);
  }
}

ThemeData primaryTheme = ThemeData(
  primaryColor: Colors.blueGrey,
  hintColor: Colors.black,
  scaffoldBackgroundColor: Colors.blueGrey,
  // Define other text styles as needed
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.blueGrey,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.white, // Or any other color
  ),
  // Add other customizations as needed
);

ThemeData secondaryTheme = ThemeData(
  primaryColor: Colors.black,
  hintColor: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.black,
  // Define other text styles as needed
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.blueGrey,
    unselectedItemColor: Colors.white, // Or any other color
  ),
  // Add other customizations as needed
);
