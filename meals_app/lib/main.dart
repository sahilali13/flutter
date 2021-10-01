import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/meal.dart';
import './assets/theme_data.dart';
import '../pages/category_meals_page.dart';
import '../pages/meal_detail_page.dart';
import '../pages/tabs_page.dart';
import '../pages/fliters_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegetarian': false,
    'vegan': false,
    'lactose': false,
  };
  List<Meal> _availableMeals = dummyMeals;

  void _setFilters(Map<String, bool> _filterData) {
    setState(() {
      _filters = _filterData;

      _availableMeals = dummyMeals.where((_meal) {
        if (_filters['gluten']! && !_meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian']! && !_meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan']! && !_meal.isVegan) {
          return false;
        }
        if (_filters['lactose']! && !_meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: themeData,
      routes: {
        '/': (_ctx) => const TabsPage(),
        CategoryMealsPage.routeName: (_ctx) =>
            CategoryMealsPage(_availableMeals),
        MealDetailPage.routeName: (_ctx) => const MealDetailPage(),
        FiltersPage.routeName: (_ctx) => FiltersPage(_filters, _setFilters),
      },
    );
  }
}
