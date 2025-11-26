// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import '../providers/theme_provider.dart';
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
          // DH-04: Show loading spinner ONLY if loading AND no data is present
          if (countryProvider.isLoading && countryProvider.countries.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // DH-03: Handle error state (This returns a full-screen error message)
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
          
          // Define the message for when the list is empty (either initially or after searching)
          final emptyListMessage = countryProvider.isSearching
              ? 'No countries match your search.'
              : 'No countries found.';

          // --- Start of Main Content (Search Bar + Conditional List/Message) ---

          return Column(
            children: [
              // BON-01: Search bar (ALWAYS VISIBLE unless in error/initial loading state)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search Countries',
                    hintText: 'e.g. United States, France, Brazil...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  // **CRITICAL**: Update the search query in the provider on change
                  onChanged: (query) {
                    countryProvider.setSearchQuery(query);
                  },
                ),
              ),
              
              // Conditional Rendering for the rest of the body (List or Empty Message)
              countryProvider.displayedCountries.isEmpty
                  ? Expanded(
                      // Show the empty message in the remaining space
                      child: Center(
                        child: Text(emptyListMessage),
                      ),
                    )
                  : Expanded(
                      // Show the GridView list
                      child: RefreshIndicator(
                        onRefresh: () => countryProvider.fetchCountries(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            // **CRITICAL**: Use the new displayedCountries list for filtering
                            itemCount: countryProvider.displayedCountries.length,
                            itemBuilder: (context, index) {
                              return CountryCard(country: countryProvider.displayedCountries[index]);
                            },
                          ),
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}