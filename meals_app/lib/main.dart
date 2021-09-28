import 'package:flutter/material.dart';

import './pages/categories_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _themeData = ThemeData(
      primarySwatch: Colors.blue,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: _themeData,
      home: const CategoriesPage(),
    );
  }
}
