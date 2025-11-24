// lib/models/country.dart

class Country {
  final String name;
  final String capital;
  final String flagUrl;
  
  // BON-02: Unique identifier for persistence
  final String alpha2Code; 
  // BON-02: State for tracking favorites
  bool isFavorite; 
  
  // NV-02 & BON-04: New detail fields fetched from API
  final int population; 
  final String region;
  final List<String> languages; // List of strings for languages

  Country({
    required this.name,
    required this.capital,
    required this.flagUrl,
    required this.alpha2Code,
    required this.population,
    required this.region,
    required this.languages,
    this.isFavorite = false, // Default to false
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    // --- DH-01: Flag URL Parsing ---
    String flagUrl = 'No Flag';
    if (json.containsKey('flags') && json['flags'] is Map) {
      // Common API structure: flags.png
      flagUrl = json['flags']['png'] ?? 'No Flag';
    } else {
      // Fallback for direct flagUrl
      flagUrl = json['flagUrl'] ?? 'No Flag';
    }

    // --- NV-02: Language Parsing ---
    // Safely parse languages: API often returns an array of objects or strings.
    List<String> languageNames = [];
    final dynamic langsData = json['languages'];
    if (langsData is List) {
        for (var lang in langsData) {
            if (lang is Map && lang.containsKey('name')) {
                // Case: [{'name': 'English'}, ...]
                languageNames.add(lang['name']);
            } else if (lang is String) {
                // Case: ['English', 'Spanish', ...]
                languageNames.add(lang);
            }
        }
    }
    
    // --- Final Object Creation ---
    return Country(
      name: json['name'] ?? 'Unknown Country',
      capital: json['capital'] ?? 'Unknown Capital',
      flagUrl: flagUrl,
      
      // BON-02: Use a reliable unique code (DH-01)
      alpha2Code: json['alpha2Code'] ?? json['cioc'] ?? json['name'] ?? 'ZZ',
      
      // NV-02 & BON-04: Safely parse numerical and string fields
      population: json['population'] is int ? json['population'] : 0,
      region: json['region'] ?? 'Unknown Region',
      languages: languageNames.isNotEmpty ? languageNames : ['Not available'],
      isFavorite: false, // Provider logic will override this on load
    );
  }
}