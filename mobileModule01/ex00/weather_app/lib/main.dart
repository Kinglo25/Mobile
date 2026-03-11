import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MyPage());
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
      appBar: AppBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text("Currently")),
          Center(child: Text("Today")),
          Center(child: Text("Weekly")),
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
