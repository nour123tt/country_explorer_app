// lib/screens/dummy_data.dart
// This file holds temporary data for frontend testing.

import '../models/country.dart';

// Temporary list of Country objects to display in the GridView (MS-02).
final List<Country> dummyCountries = [
  Country(
    name: 'Tunisia',
    capital: 'Tunis',
    // Using a placeholder flag URL for visual testing
    flagUrl: 'https://flagcdn.com/w320/tn.png', 
  ),
  Country(
    name: 'France',
    capital: 'Paris',
    flagUrl: 'https://flagcdn.com/w320/fr.png',
  ),
  Country(
    name: 'Japan',
    capital: 'Tokyo',
    flagUrl: 'https://flagcdn.com/w320/jp.png',
  ),
  Country(
    name: 'Brazil',
    capital: 'Brasília',
    flagUrl: 'https://flagcdn.com/w320/br.png',
  ),
];