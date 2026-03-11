import "package:flutter/material.dart";

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
              setState(() {
                _location = "Geolocation";
              });
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
