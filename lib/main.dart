// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import 'providers/country_provider.dart';
import 'providers/theme_provider.dart'; // <-- Import now points to the simpler file

void main() {
  runApp(
    // Use MultiProvider to manage both states
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CountryProvider(),
        ),
        ChangeNotifierProvider( // <-- Provider for Theme
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const CountryExplorerApp(),
    ),
  );
}

// MS-01: Basic app structure (StatelessWidget)
class CountryExplorerApp extends StatelessWidget {
  const CountryExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Country Explorer',
      // DH-05: Configure Light Theme
      theme: ThemeData(
        // Use a simple, modern look.
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey.shade50,
      ),
      // DH-06: Configure Dark Theme
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        // Make the app bar stand out a bit
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        // Set a dark background
        scaffoldBackgroundColor: Colors.grey.shade900,
        // Set text and icon color for dark mode
        textTheme: Typography.whiteMountainView.copyWith(
          bodyLarge: const TextStyle(color: Colors.white),
          bodyMedium: const TextStyle(color: Colors.white70),
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
        dividerColor: Colors.grey.shade700,
      ),
      // SM-04: Use the themeMode from the ThemeProvider
      themeMode: themeProvider.themeMode,
      // Set our custom MainScreen as the starting point (home).
      home: const MainScreen(),
    );
  }
}