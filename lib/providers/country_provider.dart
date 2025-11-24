// lib/providers/country_provider.dart
import 'package:flutter/foundation.dart';
import '../models/country.dart';
import '../services/country_service.dart'; // Import the service

class CountryProvider with ChangeNotifier {
  // Instance of the service
  final CountryService _service = CountryService();
  
  List<Country> _countries = []; 
  bool _isLoading = false; 
  String? _errorMessage; // DH-03: Variable to hold any API error message

  // Getters
  List<Country> get countries => _countries;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage; // Getter for error message

  // Call this when the provider is created or when refreshing (MS-05)
  Future<void> fetchCountries({bool notify = true}) async {
    if (notify) {
      _isLoading = true;
      _errorMessage = null; // Clear previous errors
      notifyListeners(); // DH-04: Show loading spinner immediately
    }

    try {
      final fetchedCountries = await _service.fetchCountries();
      _countries = fetchedCountries;
      _errorMessage = null; // Clear error if successful
    } catch (e) {
      // DH-03: Capture and store the error message
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      if (kDebugMode) {
        print('Error fetching data: $_errorMessage');
      }
      _countries = []; // Clear list on error
    } finally {
      _isLoading = false;
      notifyListeners(); // Stop loading and update UI with data/error
    }
  }

  // SM-01: Call fetch immediately when the provider is instantiated
  CountryProvider() {
    fetchCountries(notify: false); // Initial fetch, don't notify until data is ready
  }
}