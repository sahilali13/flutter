import 'package:flutter/material.dart';

import './assets/theme_data.dart';
import './assets/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: themeData,
      routes: routes,
    );
  }
}
