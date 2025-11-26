// lib/services/country_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';

class CountryService {
  // DH-02: Base URL for the countries API
  static const String _baseUrl = 'https://www.apicountries.com/countries'; 
  
  // BON-06: Base URL for the Frankfurter Currency Exchange API (No API Key needed!)
  static const String _currencyBaseUrl = 'https://api.frankfurter.dev';

  Future<List<Country>> fetchCountries() async {
    // DH-02: Make the HTTP call.
    final uri = Uri.parse(_baseUrl);

    try {
      final response = await http.get(uri);

      // DH-03: Handle HTTP status codes gracefully.
      if (response.statusCode == 200) {
        // The API returns a List of country objects.
        // We must cast the decoded JSON to a List<dynamic>.
        final List<dynamic> jsonList = json.decode(response.body);

        // Map the list of JSON objects to a List<Country> using the fromJson factory.
        return jsonList.map((json) => Country.fromJson(json)).toList();
      } else {
        // DH-03: Handle server errors (e.g., 404, 500)
        throw Exception('Failed to load countries. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // DH-03: Handle network errors (e.g., no internet)
      // Throw a specific error so the provider can handle the UI display.
      throw Exception('Network Error: Could not connect to the API. Details: $e');
    }
  }

  // BON-06: New function to fetch the exchange rate from the country's currency to EUR.
  // The function takes the three-letter currency code (e.g., "USD", "GBP").
  Future<double> fetchExchangeRate(String targetCurrencyCode) async {
    // Request the latest rates, specifying the target currency code.
    // e.g., https://api.frankfurter.dev/latest?symbols=USD
    final uri = Uri.parse('$_currencyBaseUrl/latest?symbols=$targetCurrencyCode');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        
        // The API returns the rate relative to the base (EUR by default).
        // The result is in jsonMap['rates']
        
        final Map<String, dynamic> rates = jsonMap['rates'];

        if (rates.containsKey(targetCurrencyCode)) {
          // The value is the amount of the target currency (e.g., USD) that equals 1 EUR.
          // We return this rate as a double.
          return rates[targetCurrencyCode] as double;
        } else {
          // This handles cases where the currency code might be invalid or not supported.
          throw Exception('Currency code "$targetCurrencyCode" not found in exchange rates.');
        }
      } else {
        throw Exception('Failed to load currency data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      throw Exception('Currency Network Error: Could not connect to the API. Details: $e');
    }
  }
}