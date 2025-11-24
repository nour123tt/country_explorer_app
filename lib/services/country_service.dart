// lib/services/country_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';

class CountryService {
  // DH-02: Base URL for the API
  static const String _baseUrl = 'https://www.apicountries.com/countries'; 

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
}