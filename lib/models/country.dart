// lib/models/country.dart


class Country {

  final String name;
  final String capital;
  final String flagUrl; 

  Country({
    required this.name,
    required this.capital,
    required this.flagUrl,
  });


  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? 'Unknown Country',
      capital: json['capital'] ?? 'Unknown Capital',
      flagUrl: json['flagUrl'] ?? 'No Flag',
    );
  }
}