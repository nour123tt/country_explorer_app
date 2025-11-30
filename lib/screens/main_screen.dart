// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import '../providers/theme_provider.dart';
import 'country_card.dart';
import 'favorites_screen.dart'; 
// CRITICAL: Import the actual Country model here.
import '../models/country.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // 1. HELPER: Function for consistent detail row formatting in the drawer
  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)
            ),
          ),
        ],
      ),
    );
  }

  // 2. NEW WIDGET: Builds the detail card UI for Tunisia in the Drawer.
  // We make this a Consumer so it rebuilds when data arrives.
  Widget _TunisiaDrawerDetails(BuildContext context) {
    // 3. LOGIC: Define a placeholder/default object
    final placeholderTunisia = Country(
        name: 'Tunisia (Loading...)', // Temporary placeholder name
        capital: '...',
        region: '...',
        population: 0,
        flagUrl: 'https://flagcdn.com/w320/tn.png',
        currencyCode: 'TND',
        languages: ['...'],
        alpha2Code: 'TN'
    );
    
    // Use Consumer to react to data loading from the CountryProvider
    return Consumer<CountryProvider>(
      builder: (context, countryProvider, child) {
        // Look up Tunisia's data (listen: false is not needed here as we are in a Consumer)
        final Country? tunisiaCountry = countryProvider.countries.cast<Country?>().firstWhere(
            (country) => country?.name == 'Tunisia',
            orElse: () => null, 
        );

        // Determine which data to display: the real data or the placeholder
        final Country displayCountry = tunisiaCountry ?? placeholderTunisia;
        final languagesString = displayCountry.languages.join(', ');

        // Check if data is still loading (using the placeholder name as a proxy)
        final bool isLoading = displayCountry.name.contains('Loading');
        
        // Use the actual name for the header title, if available
        final String headerTitle = isLoading ? "Tunisia (Loading...)" : displayCountry.name;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drawer Header with Country Name
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🇹🇳 My Country',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    headerTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Flag Image
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Image.network(
                  displayCountry.flagUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Text("Flag failed to load")),
                ),
              ),
            ),

            // Detail ListTiles
            const Divider(),
            _buildDetailRow(context, 'Capital:', displayCountry.capital),
            _buildDetailRow(context, 'Region:', displayCountry.region),
            // Show CircularProgressIndicator if population is 0 (and loading)
            _buildDetailRow(context, 'Population:', isLoading && displayCountry.population == 0
                ? '...'
                : displayCountry.population.toString()),

            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 10, bottom: 5),
              child: Text('Economic Details', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),
            _buildDetailRow(context, 'Currency Code:', displayCountry.currencyCode),

            
            _buildDetailRow(context, 'Languages:', languagesString),
            const Divider(),

            const SizedBox(height: 20),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // This lookup logic is now only needed to ensure a country list exists,
    // but the drawer details widget handles the state changes.
    final countryProvider = Provider.of<CountryProvider>(context, listen: false);

    return Scaffold(
      // 5. CRITICAL: The Drawer property itself.
      drawer: Drawer(
        child: SingleChildScrollView( 
          // Pass context to the helper widget
          child: _TunisiaDrawerDetails(context), 
        ),
      ),
      
      appBar: AppBar(
        // 1. FIX: Removed "Open Tunisia Details" button from the body.
        // 2. FIX: We now explicitly set the leading icon back to the standard menu icon.
        leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // This line programmatically opens the drawer.
                  Scaffold.of(context).openDrawer();
                },
              );
            }
        ),
        
        // MS-01: Title
        title: const Text('Country Explorer'),
        centerTitle: true,
        // SM-05: Add the dark mode icon to the actions
        actions: [
          // NEW ICON: Favorites navigation button
          IconButton(
            icon: const Icon(Icons.favorite), // Icon to navigate to favorites screen
            onPressed: () {
              // Navigate to the FavoritesScreen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FavoritesScreen()),
              );
            },
          ),
          // END NEW ICON

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
          if (countryProvider.isLoading && countryProvider.countries.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

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
                      onPressed: () => countryProvider.fetchCountries(),
                      child: const Text('Retry Fetching Data'),
                    ),
                  ],
                ),
              ),
            );
          }
          
          final emptyListMessage = countryProvider.isSearching
              ? 'No countries match your search.'
              : 'No countries found.';

          // --- Start of Main Content ---
          return Column(
            children: [
              // BON-01: Search bar (Original Code)
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
                  onChanged: (query) {
                    countryProvider.setSearchQuery(query);
                  },
                ),
              ),
              
              // Conditional Rendering for the rest of the body (Original Code)
              countryProvider.displayedCountries.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(emptyListMessage),
                      ),
                    )
                  : Expanded(
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