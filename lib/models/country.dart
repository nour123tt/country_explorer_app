// lib/models/country.dart

class Country {
  final String name;
  final String capital;
  final String flagUrl; 
  // ... potentially add more fields later (population, region)

  Country({
    required this.name,
    required this.capital,
    required this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    // DH-01: Update parsing logic for real-world API data.
    // Assuming the flag URL is nested under 'flags' for better compatibility:
    String flagUrl = 'No Flag';
    if (json.containsKey('flags') && json['flags'] is Map) {
      flagUrl = json['flags']['png'] ?? 'No Flag';
    } else {
      // Fallback in case 'flagUrl' is directly at the top level (as in your original code)
      flagUrl = json['flagUrl'] ?? 'No Flag';
    }

    return Country(
      name: json['name'] ?? 'Unknown Country',
      capital: json['capital'] ?? 'Unknown Capital',
      flagUrl: flagUrl, // Use the extracted/default flag URL
    );
  }
}