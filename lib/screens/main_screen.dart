// lib/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'country_card.dart';        // Import the card we just created
import 'dummy_data.dart';          // Import the temporary data list

// The main screen that will show the list of countries.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For the frontend test, we use the temporary list.
    final countries = dummyCountries; 

    return Scaffold(
      appBar: AppBar(
        // MS-01: Title
        title: const Text('Country Explorer'),
        centerTitle: true,
      ),
      // MS-02: Grid view showing all countries
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          // Grid layout configuration
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,        // Two countries per row
            childAspectRatio: 0.75,   // Aspect ratio (width/height)
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: countries.length,
          itemBuilder: (context, index) {
            // Create a CountryCard for each item in the list
            return CountryCard(country: countries[index]);
          },
        ),
      ),
    );
  }
}