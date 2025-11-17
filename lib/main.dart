// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import 'providers/country_provider.dart'; 

void main() {
  // SM-02: Setting up Provider at the top of the widget tree.
  runApp(
    ChangeNotifierProvider(
      // The state manager for our app (placeholder for now).
      create: (context) => CountryProvider(), 
      child: const CountryExplorerApp(),
    ),
  );
}

// MS-01: Basic app structure (StatelessWidget).
class CountryExplorerApp extends StatelessWidget {
  const CountryExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Explorer',
      theme: ThemeData(
        // Use a simple, modern look.
        primarySwatch: Colors.blue,
      ),
      // Set our custom MainScreen as the starting point (home).
      home: const MainScreen(),
    );
  }
}