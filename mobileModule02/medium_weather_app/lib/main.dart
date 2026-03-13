import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const MyPage());
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _location = "";
  List<Map<String, dynamic>> _suggestions = [];

  Future<void> _searchCity(String query) async {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }
    final response = await http.get(
      Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$query&count=5',
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'];
      if (results == null) {
        setState(() {
          _suggestions = [];
        });
        return;
      }
      setState(() {
        _suggestions = List<Map<String, dynamic>>.from(results);
      });
    }
  }

  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _location = "Geolocalisation is disabled";
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _location = "Geolocalisation permission denied";
          });
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _location = "${position.latitude}, ${position.longitude}";
      });
    } catch (e) {
      setState(() {
        _location = "Location unavailable";
      });
    }
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
          decoration: InputDecoration(hintText: "Search location..."),
          onChanged: (val) {
            _searchCity(val);
          },
          onSubmitted: (val) {
            setState(() {
              _location = val;
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              _getLocation();
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Text(
              _location.isEmpty ? "Currently" : "Currently $_location",
            ),
          ),
          Center(child: Text(_location.isEmpty ? "Today" : "Today $_location")),
          Center(
            child: Text(_location.isEmpty ? "Weekly" : "Weekly $_location"),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Currently", icon: Icon(Icons.sunny)),
            Tab(text: "Today", icon: Icon(Icons.sunny_snowing)),
            Tab(text: "Weekly", icon: Icon(Icons.cloud)),
          ],
        ),
      ),
    );
  }
}
