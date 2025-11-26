// lib/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import '../providers/country_provider.dart'; // Import our provider
import '../providers/theme_provider.dart'; // <-- Import now points to the simpler file
import 'country_card.dart';

// The main screen that will show the list of countries.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the ThemeProvider to get the icon and cycle function
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        // MS-01: Title
        title: const Text('Country Explorer'),
        centerTitle: true,
        // SM-05: Add the dark mode icon to the actions
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
      ),
      // SM-03: Use Consumer to listen to changes in CountryProvider
      body: Consumer<CountryProvider>(
        builder: (context, countryProvider, child) {
          // DH-04: Show loading spinner
          if (countryProvider.isLoading && countryProvider.countries.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // DH-03: Handle error state
          if (countryProvider.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 60),
                    const SizedBox(height: 10),
                    Text(
                      'Error: ${countryProvider.errorMessage}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      // Allow user to retry fetching data
                      onPressed: () => countryProvider.fetchCountries(),
                      child: const Text('Retry Fetching Data'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Handle empty list case (e.g., if API returned success but empty list)
          if (countryProvider.countries.isEmpty) {
            return const Center(child: Text('No countries found.'));
          }

          // MS-05: Pull down to refresh implementation
          return RefreshIndicator(
            onRefresh: () => countryProvider.fetchCountries(), // Call fetch function on refresh
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              // MS-02, MS-03: Grid view showing flag, name, capital from provider data
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: countryProvider.countries.length,
                itemBuilder: (context, index) {
                  return CountryCard(country: countryProvider.countries[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}