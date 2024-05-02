import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expression Evaluator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExpressionEvaluator(),
    );
  }
}

class ExpressionEvaluator extends StatefulWidget {
  const ExpressionEvaluator({super.key});

  @override
  _ExpressionEvaluatorState createState() => _ExpressionEvaluatorState();
}

class _ExpressionEvaluatorState extends State<ExpressionEvaluator> {
  String expression = '';
  String result = '';
  final RegExp validChars = RegExp(r'^[0-9+*/().-]*$');

  void evaluateExpression() {
    if (isValidExpression(expression)) {
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        setState(() {
          result = eval.toString();
        });
      } catch (e) {
        setState(() {
          result = 'Error';
        });
      }
    } else {
      setState(() {
        result = 'Expresión inválida';
      });
    }
  }

  bool isValidExpression(String expr) {
    return validChars.hasMatch(expr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expression Evaluator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  expression = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Ingrese la expresión',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: evaluateExpression,
              child: const Text('Evaluar'),
            ),
            const SizedBox(height: 20),
            Text(
              'Resultado: $result',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
