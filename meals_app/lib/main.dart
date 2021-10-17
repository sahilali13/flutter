import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import './models/meal.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool?> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  final List<Meal> _favoriteMeals = [];

  void _setFilters({
    required Map<String, bool?> filterData,
  }) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((_meal) {
        if (_filters['gluten']! && !_meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !_meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !_meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !_meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite({required String mealId}) {
    final _existingIndex =
        _favoriteMeals.indexWhere((_meal) => _meal.id == mealId);
    if (_existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(_existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((_meal) => _meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite({required String id}) {
    return _favoriteMeals.any((_meal) => _meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: const TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: Colors.amber,
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_ctx) => TabsScreen(favoriteMeals: _favoriteMeals),
        CategoryMealsScreen.routeName: (_ctx) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (_ctx) => MealDetailScreen(
            toggleFavorite: _toggleFavorite, isFavorite: _isMealFavorite),
        FiltersScreen.routeName: (_ctx) =>
            FiltersScreen(currentFilters: _filters, saveFilters: _setFilters),
      },
      onUnknownRoute: (_settings) {
        return MaterialPageRoute(
          builder: (_ctx) => const CategoriesScreen(),
        );
      },
    );
  }
}
