import 'package:flutter/material.dart';

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

class MyPage extends StatelessWidget {
  const MyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello General Kenobi"),
            ElevatedButton(
              onPressed: () {
                // ignore: avoid_print
                print("button pressed");
              },
              child: Text("Click me"),
            ),
          ],
        ),
      ),
    );
  }
}
