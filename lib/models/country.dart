// lib/models/country.dart

/// DH-01: Creates a Country class to represent data fetched from the API.
class Country {
  final String name;
  final String capital;
  final String flagUrl; 

  Country({
    required this.name,
    required this.capital,
    required this.flagUrl,
  });

  // DH-01: UPDATED factory constructor to correctly parse complex API JSON.
  factory Country.fromJson(Map<String, dynamic> json) {
    // 1. Extract Name (Nested under 'name', using 'common' name)
    final String commonName = json['name']['common'] ?? 'Unknown Country';

    // 2. Extract Capital (It's an array, so we take the first element or 'N/A')
    String capitalValue = 'N/A';
    // Check if 'capital' exists, is a list, and is not empty.
    if (json['capital'] != null && json['capital'] is List && (json['capital'] as List).isNotEmpty) {
      capitalValue = json['capital'][0];
    }
    
    // 3. Extract Flag URL (Nested under 'flags', using the 'png' image)
    // We check for the 'png' field, as 'svg' might also be present.
    final String flagUrlValue = json['flags'] != null ? (json['flags']['png'] ?? '') : '';

    // Create the clean Dart object with the extracted values.
    return Country(
      name: commonName,
      capital: capitalValue,
      flagUrl: flagUrlValue,
    );
  }
}