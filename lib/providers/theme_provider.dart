// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // DH-01: Start with light mode since we can't detect system settings without context/plugins.
  ThemeMode _themeMode = ThemeMode.light;
  
  // DH-02: Key for SharedPreferences storage - REMOVED

  ThemeMode get themeMode => _themeMode;

  // DH-07: Getter to provide the correct icon for the cycle (Light <-> Dark)
  IconData get themeIcon {
    if (_themeMode == ThemeMode.light) {
      // Current: Light. Next: Dark. Show moon icon.
      return Icons.dark_mode_outlined;
    } else {
      // Current: Dark. Next: Light. Show sun icon.
      return Icons.light_mode_outlined;
    }
  }

  // Constructor: Load saved theme preference on startup - REMOVED
  ThemeProvider();
  
  // Helper to convert ThemeMode enum to string for storage - REMOVED
  // Helper to convert string back to ThemeMode enum - REMOVED
  // Load the theme mode from local storage - REMOVED
  
  // Toggle the theme and save the preference - MODIFIED
  void toggleTheme(ThemeMode newMode) {
    if (_themeMode != newMode) {
      _themeMode = newMode;
      notifyListeners();
      // Save the new preference - REMOVED
    }
  }

  // Convenience method to cycle between Light and Dark modes
  void cycleTheme() {
    // Cycles only between Light and Dark (simplest without System preference/persistence)
    if (_themeMode == ThemeMode.light) {
      toggleTheme(ThemeMode.dark);
    } else { // Current mode is ThemeMode.dark
      toggleTheme(ThemeMode.light);
    }
  }
}