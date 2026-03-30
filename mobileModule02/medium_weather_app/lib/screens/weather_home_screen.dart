import "package:flutter/material.dart";

import "../services/geocoding_service.dart";
import "../services/location_service.dart";

/// Main screen for searching and displaying weather info.
class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GeocodingService _geocodingService = GeocodingService();
  final LocationService _locationService = LocationService();

  String _location = "";
  List<Map<String, dynamic>> _suggestions = [];

  /// Search for city suggestions and update the UI.
  Future<void> _searchCity(String query) async {
    final suggestions = await _geocodingService.searchCity(query);
    setState(() {
      _suggestions = suggestions;
    });
  }

  /// Get the current location label and update the UI.
  Future<void> _getLocation() async {
    final location = await _locationService.getLocationLabel();
    setState(() {
      _location = location;
    });
  }

  /// Build a display label for a city suggestion.
  String _buildSuggestionLabel(Map<String, dynamic> suggestion) {
    final name = suggestion["name"]?.toString() ?? "Unknown city";
    final region = suggestion["admin1"]?.toString() ?? "";
    final country = suggestion["country"]?.toString() ?? "";

    if (region.isEmpty && country.isEmpty) {
      return name;
    }
    if (region.isEmpty) {
      return "$name, $country";
    }
    if (country.isEmpty) {
      return "$name, $region";
    }
    return "$name, $region, $country";
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _getLocation();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(hintText: "Search location..."),
          onChanged: _searchCity,
          onSubmitted: (value) {
            setState(() {
              _location = value;
              _suggestions = [];
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: _getLocation,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_suggestions.isNotEmpty)
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _suggestions[index];
                  final label = _buildSuggestionLabel(suggestion);

                  return ListTile(
                    dense: true,
                    title: Text(label),
                    onTap: () {
                      setState(() {
                        _location = label;
                        _suggestions = [];
                      });
                    },
                  );
                },
              ),
            ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(
                  child: Text(
                    _location.isEmpty ? "Currently" : "Currently $_location",
                  ),
                ),
                Center(
                  child: Text(_location.isEmpty ? "Today" : "Today $_location"),
                ),
                Center(
                  child: Text(
                    _location.isEmpty ? "Weekly" : "Weekly $_location",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Currently", icon: Icon(Icons.sunny)),
            Tab(text: "Today", icon: Icon(Icons.sunny_snowing)),
            Tab(text: "Weekly", icon: Icon(Icons.cloud)),
          ],
        ),
      ),
    );
  }
}
