// lib/providers/country_provider.dart

import 'package:flutter/foundation.dart';
import '../models/country.dart';
import '../services/country_service.dart'; // Import the service

class CountryProvider with ChangeNotifier {
  // --- Service Instance ---
  final CountryService _service = CountryService();
  
  // --- Private State Variables ---
  List<Country> _countries = []; 
  bool _isLoading = false; 
  String? _errorMessage; 
  String _searchQuery = ''; // BON-01: State variable for the search query

  // --- Constructor: Initial Data Fetch ---
  CountryProvider() {
    // SM-01: Call fetch immediately when the provider is instantiated
    fetchCountries(notify: false); 
  }

  // --- Getters (Read-Only Access to State) ---
  List<Country> get countries => _countries;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSearching => _searchQuery.isNotEmpty; // BON-01: Check if filtering

  // --- Computed Getter for UI Display ---
  List<Country> get displayedCountries {
    if (_searchQuery.isEmpty) {
      return _countries; // Return full list if no search query
    }

    final lowerCaseQuery = _searchQuery.toLowerCase();

    // Filter the main list of countries
    return _countries.where((country) {
      final nameMatches = country.name.toLowerCase().contains(lowerCaseQuery);
      
      final capitalMatches = country.capital != null && 
                             country.capital!.toLowerCase().contains(lowerCaseQuery);

      return nameMatches || capitalMatches;
    }).toList();
  }

  // --- State Mutators (Public Methods) ---

  // BON-01: Method to update the search query and trigger a filter refresh
  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners(); 
  }

  // BON-04: Sort by name (A-Z) then by population (Descending)
  void sortCountries() {
    _countries.sort((a, b) {
      // 1. Primary Sort: By Name (A to Z) - case-insensitive
      final nameA = a.name.toLowerCase();
      final nameB = b.name.toLowerCase();
      final nameCompare = nameA.compareTo(nameB);

      if (nameCompare != 0) {
        return nameCompare;
      }

      // 2. Secondary Sort: By Population (Descending - bigger first)
      return b.population.compareTo(a.population);
    });

    notifyListeners(); 
  }

  // MS-05: Call this when the provider is created or when refreshing
  Future<void> fetchCountries({bool notify = true}) async {
    if (notify) {
      _isLoading = true;
      _errorMessage = null; 
      notifyListeners(); // DH-04: Show loading spinner immediately
    }

    try {
      final fetchedCountries = await _service.fetchCountries();
      _countries = fetchedCountries;
      _errorMessage = null; 
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
}