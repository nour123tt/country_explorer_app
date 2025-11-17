// lib/screens/country_card.dart

import 'package:flutter/material.dart';
import '../models/country.dart';
// 1. Import the screen we want to navigate to
import 'detail_screen.dart'; 

// MS-04: Using StatelessWidget since the card content is static.
class CountryCard extends StatelessWidget {
  final Country country;

  const CountryCard({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell( 
        // NV-01: Implement navigation when the card is tapped
        onTap: () {
          // Navigator.push moves the user to a new screen.
          Navigator.of(context).push(
            MaterialPageRoute(
              // The DetailScreen needs the Country object to display its details.
              builder: (context) => DetailScreen(country: country),
            ),
          );
        },
        child: Column(
          // ... (Rest of the UI code is unchanged)
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  country.flagUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Capital: ${country.capital}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}