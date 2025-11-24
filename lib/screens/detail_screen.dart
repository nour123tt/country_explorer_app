// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // <-- New import for number formatting
import '../models/country.dart';

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

  @override
  Widget build(BuildContext context) {
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
            
            // --- Core Details (Replaced old placeholder) ---
            
            // Capital (Kept for visual consistency, but now in the DetailRow style)
            _buildDetailRow('Capital', country.capital),
            
            // NV-02: Region Detail
            _buildDetailRow('Region', country.region),
            
            // NV-02: Population Detail (Formatted)
            _buildDetailRow('Population', formattedPopulation),
            
            const Divider(height: 30, thickness: 1),

            // NV-02: Language Details
            const Text(
              'Official Languages:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              languagesString,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
            ),
            
            const Divider(height: 30, thickness: 1),

            // BON-02: Favorite Status (Simple display of the state)
            Row(
              children: [
                Icon(
                  country.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: country.isFavorite ? Colors.red : Colors.grey,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  country.isFavorite ? 'This is a favorite country!' : 'Not currently a favorite.',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}