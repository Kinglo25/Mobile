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
  final _expressionController = TextEditingController(text: '0');
  final _resultController = TextEditingController(text: '0');

  Widget button(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          print("button pressed: $text");
        },
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator"), centerTitle: true),
      body: Column(
        children: [
          TextField(
            controller: _expressionController,
            readOnly: true,
            textAlign: TextAlign.right,
          ),
          TextField(
            controller: _resultController,
            readOnly: true,
            textAlign: TextAlign.right,
          ),
          Spacer(),
          Row(
            children: [
              button("7"),
              button("8"),
              button("9"),
              button("C"),
              button("AC"),
            ],
          ),
          Row(
            children: [
              button("4"),
              button("5"),
              button("6"),
              button("+"),
              button("-"),
            ],
          ),
          Row(
            children: [
              button("1"),
              button("2"),
              button("3"),
              button("*"),
              button("/"),
            ],
          ),
          Row(
            children: [
              button("0"),
              button("."),
              button("="),
              Expanded(child: SizedBox()),
              Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}
