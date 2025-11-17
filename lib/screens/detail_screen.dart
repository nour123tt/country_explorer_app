// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    // NV-02: Show country info.
    return Scaffold(
      appBar: AppBar(
        // NV-03: Allows easy return to main screen (via back button).
        title: Text(widget.country.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                widget.country.flagUrl,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            
            Text(
              'Capital:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
            Text(
              widget.country.capital,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const Divider(height: 30),

            const Text(
              'Placeholder for NV-02: More details will be added here later.',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}