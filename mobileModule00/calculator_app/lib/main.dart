import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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

  Widget button(String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(label),
        child: Text(label),
      ),
    );
  }

  String evaluateExpression(String expr) {
    try {
      ExpressionParser p = GrammarParser();
      Expression exp = p.parse(expr);
      var context = ContextModel();
      var evaluator = RealEvaluator(context);
      num eval = evaluator.evaluate(exp);
      return eval.toString();
    } catch (e) {
      return "Error";
    }
  }

  void _onButtonPressed(String label) {
    if (label == "AC") {
      _expressionController.text = '0';
    } else if (label == "C") {
      if (_expressionController.text == '0') {
        _expressionController.text = '0';
      } else {
        _expressionController.text = _expressionController.text.substring(
          0,
          _expressionController.text.length - 1,
        );
      }
    } else if (label == "=") {
      _resultController.text = evaluateExpression(_expressionController.text);
    } else {
      if (_expressionController.text == '0') {
        _expressionController.text = label;
      } else {
        _expressionController.text += label;
      }
    }
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
