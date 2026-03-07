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

class MyPage extends StatefulWidget {
  const MyPage({super.key});
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String _text = "Hello General Kenobi!";
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_text),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  (_i % 2 == 0)
                      ? _text = "Hello World!"
                      : _text = "Hello General Kenobi!";
                  _i += 1;
                });
              },
              child: Text("Click me"),
            ),
          ],
        ),
      ),
    );
  }
}
