// lib/providers/country_provider.dart
import 'package:flutter/foundation.dart';
import '../models/country.dart';

// SM-01: Must extend or mix in ChangeNotifier to work with Provider.
class CountryProvider with ChangeNotifier {
  // Initialize the list of countries as empty.
  List<Country> _countries = []; 

  // Loading state (DH-04)
  bool _isLoading = false; 

  // Getters for external access
  List<Country> get countries => _countries;
  bool get isLoading => _isLoading;

  // We will add the data fetching logic here in the next step.
  CountryProvider() {
    // Optionally call fetch function on creation later
  }
}