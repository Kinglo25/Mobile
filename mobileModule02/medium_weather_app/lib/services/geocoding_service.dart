import "dart:convert";

import "package:http/http.dart" as http;

/// Service for searching cities using the Open-Meteo geocoding API.
class GeocodingService {
  /// Returns a list of city info maps matching the query.
  Future<List<Map<String, dynamic>>> searchCity(String query) async {
    if (query.isEmpty) {
      return [];
    }

    final encodedQuery = Uri.encodeComponent(query); // URL-encode the query
    final response = await http.get(
      Uri.parse(
        // Limit results to 5 cities
        "https://geocoding-api.open-meteo.com/v1/search?name=$encodedQuery&count=5",
      ),
    );

    if (response.statusCode != 200) {
      return [];
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data["results"];

    if (results == null) {
      return [];
    }

    // Convert dynamic list to List<Map<String, dynamic>>
    return List<Map<String, dynamic>>.from(results as List<dynamic>);
  }
}
