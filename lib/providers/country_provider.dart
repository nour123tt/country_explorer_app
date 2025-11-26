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
  
  // BON-01 Search Bar Implementation: State variable for the search query
  String _searchQuery = ''; 

  // Getters
  List<Country> get countries => _countries;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage; // Getter for error message

  // BON-01: Getter to check if we are currently filtering
  bool get isSearching => _searchQuery.isNotEmpty;

  // BON-01: The primary list the UI should use (full list or filtered list)
  List<Country> get displayedCountries {
    if (_searchQuery.isEmpty) {
      return _countries; // Return full list if no search query
    }

    // Convert query to lower case for case-insensitive search
    final lowerCaseQuery = _searchQuery.toLowerCase();

    // Filter the main list of countries
    return _countries.where((country) {
      // Check if the country name contains the search query
      final nameMatches = country.name.toLowerCase().contains(lowerCaseQuery);
      
      // Optional: Check if capital matches, if it exists
      final capitalMatches = country.capital != null && 
                             country.capital!.toLowerCase().contains(lowerCaseQuery);

      // Return true if either the name or the capital matches
      return nameMatches || capitalMatches;
    }).toList();
  }

  // BON-01: Method to update the search query and trigger a filter refresh
  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    // Notify listeners so MainScreen re-renders with the filtered list
    notifyListeners(); 
  }

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
      // Clear search query on a fresh fetch
      _searchQuery = ''; // Clear search query on a fresh fetch
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