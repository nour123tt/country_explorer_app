// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:provider/provider.dart'; 
import '../models/country.dart';
import '../providers/theme_provider.dart'; 
// <<< NEW IMPORTS >>>
import '../providers/country_provider.dart'; // Import CountryProvider
// <<< END NEW IMPORTS >>>

// BON-06: We no longer need the CountryService import since we removed the fetching logic.
// import '../services/country_service.dart';

// NV-04: The detail screen uses a StatefulWidget as required.
class DetailScreen extends StatefulWidget {
  final Country country;

  const DetailScreen({
    super.key,
    required this.country,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // BON-06: REMOVED: No need for Future<double> or initState logic
  // late Future<double> _exchangeRateFuture;

  // BON-06: REMOVED: The entire initState block that fetched the currency rate
  @override
  void initState() {
    super.initState();
    // Keeping initState clean, as the currency logic is now simple display.
  }

  // Helper to build a clean detail row for consistency
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, // Align to top for multi-line text
        children: [
          Text(
            '$title:',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10), // Small space between title and value
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }

  // BON-06: SIMPLIFIED widget to only display the Currency Code
  Widget _buildCurrencyCard() {
    final currencyCode = widget.country.currencyCode;

    // Only display the currency code if it's available
    if (currencyCode == 'N/A') {
      return const Text(
        'Currency details not available.',
        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
      );
    }

    return _buildDetailRow(
      'Currency Code', 
      currencyCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access the ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Access the CountryProvider for state changes (watch)
    final countryProvider = context.watch<CountryProvider>();
    final isFavorite = countryProvider.isFavorite(widget.country); // Check current favorite status

    // Access the country object from the widget
    final country = widget.country;

    // Format population number with commas for readability
    final populationFormatter = NumberFormat('#,###', 'en_US');
    final formattedPopulation = populationFormatter.format(country.population);

    // Format languages list into a single string
    final languagesString = country.languages.join(', ');

    // NV-02: Show country info.
    return Scaffold(
      appBar: AppBar(
        // NV-03: Allows easy return to main screen (via back button).
        title: Text(country.name),
        centerTitle: true,
        actions: [
          // <<< NEW: FAVORITES TOGGLE ICON >>>
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null, // Red heart if favorited
            ),
            onPressed: () {
              // Toggle the favorite status using the provider
              countryProvider.toggleFavorite(country);

              // Optional: Show a small confirmation message (Snackbar)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isFavorite 
                      ? '${country.name} removed from favorites.' 
                      : '${country.name} added to favorites!'),
                  duration: const Duration(milliseconds: 800),
                ),
              );
            },
          ),
          // <<< END NEW ICON >>>
          
          // SM-05: Add the dark mode icon to the actions (Existing logic)
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0), // Increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flag at the top
            Center(
              child: Image.network(
                country.flagUrl,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),

            // --- Core Details ---

            // Capital
            _buildDetailRow('Capital', country.capital),

            // NV-02: Region Detail
            _buildDetailRow('Region', country.region),

            // NV-02: Population Detail (Formatted)
            _buildDetailRow('Population', formattedPopulation),

            const Divider(height: 30, thickness: 1),

            // BON-06: Display the simplified Currency Card
            const Text(
              'Currency Details', // Changed title to be less about "Exchange"
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 15),
            _buildCurrencyCard(),
            
            const Divider(height: 30, thickness: 1),

            // NV-02: Language Details
            const Text(
              'Official Languages:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              languagesString,
              style: const TextStyle(fontSize: 18, color: Color.fromARGB(221, 132, 206, 245)),
            ),

            const Divider(height: 30, thickness: 1),

            // BON-02: Favorite Status (Removed static check, now UI reacts to provider)
            // You can remove this section entirely, as the icon in the AppBar serves this purpose.
            /* Row(
              children: [
                Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  isFavorite ? 'This is a favorite country!' : 'Not currently a favorite.',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            */
          ],
        ),
      ),
    );
  }
}