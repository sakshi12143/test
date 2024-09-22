import 'package:flutter/material.dart';
import 'round_counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pradakshina Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RoundCounter(),
    );
  }
}
