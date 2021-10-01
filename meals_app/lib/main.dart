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

  final List<Meal> _favouriteMeals = [];

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

  void _toggleFavourite(String _mealId) {
    final _existingIndex =
        _favouriteMeals.indexWhere((_meal) => _meal.id == _mealId);
    if (_existingIndex >= 0) {
      _favouriteMeals.removeAt(_existingIndex);
    } else {
      _favouriteMeals
          .add(dummyMeals.firstWhere((_meal) => _meal.id == _mealId));
    }
  }

  bool _isMealFavourite(String _id) {
    return _favouriteMeals.any((_meal) => _meal.id == _id);
  }

  @override
  Widget build(BuildContext context) {
    var _routes = {
      '/': (_ctx) => TabsPage(_favouriteMeals),
      CategoryMealsPage.routeName: (_ctx) => CategoryMealsPage(_availableMeals),
      MealDetailPage.routeName: (_ctx) =>
          MealDetailPage(_toggleFavourite, _isMealFavourite),
      FiltersPage.routeName: (_ctx) => FiltersPage(_filters, _setFilters),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: themeData,
      routes: _routes,
    );
  }
}
