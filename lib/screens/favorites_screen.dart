// lib/screens/favorites_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
// <<< NEW IMPORT >>>
import '../providers/theme_provider.dart'; // Import ThemeProvider
// <<< END NEW IMPORT >>>
import 'country_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Use a Consumer to listen specifically to the CountryProvider
    return Consumer<CountryProvider>(
      builder: (context, countryProvider, child) {
        final favoriteCountries = countryProvider.favoriteCountries;
        final itemCount = favoriteCountries.length;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorite Countries'),
            centerTitle: true,
            // <<< NEW: DARK MODE TOGGLE ICON >>>
            actions: [
              IconButton(
                // Use the getter from ThemeProvider to show the appropriate icon
                icon: Icon(themeProvider.themeIcon),
                onPressed: () {
                  // Call the cycleTheme method
                  themeProvider.cycleTheme();
                },
              ),
            ],
            // <<< END NEW ICON >>>
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: itemCount == 0
                ? const Center(
                    // Display a friendly message if the list is empty
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          'You haven\'t added any favorites yet!',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        Text(
                          'Tap the heart icon on any country to add it.',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      // Use the same CountryCard to display the favorited countries
                      return CountryCard(country: favoriteCountries[index]);
                    },
                  ),
          ),
        );
      },
    );
  }
}