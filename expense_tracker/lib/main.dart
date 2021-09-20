import 'package:flutter/material.dart';

import './widgets/homePage.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: HomePage(),
    );
  }
}
