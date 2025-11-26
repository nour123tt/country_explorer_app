// lib/screens/favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import 'country_card.dart'; // Reuse the existing card widget

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the provider for the list of favorite countries
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorite Countries'),
        centerTitle: true,
      ),
      body: Consumer<CountryProvider>(
        builder: (context, provider, child) {
          final favoriteCountries = provider.favoriteCountries;

          if (favoriteCountries.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No favorites yet!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text('Tap the heart icon on any country to add it here.'),
                ],
              ),
            );
          }

          // MS-02: Reuse the GridView structure
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 0.75, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favoriteCountries.length,
              itemBuilder: (context, index) {
                // MS-03: Reuse the existing CountryCard widget
                return CountryCard(country: favoriteCountries[index]);
              },
            ),
          );
        },
      ),
    );
  }
}