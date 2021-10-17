import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> _availableMeals;

  const CategoryMealsScreen({
    Key? key,
    required availableMeals,
  })  : _availableMeals = availableMeals,
        super(key: key);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? _categoryTitle = '';
  List<Meal> _displayedMeals = [];
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final _routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      _categoryTitle = _routeArgs['title'];
      final _categoryId = _routeArgs['id'];
      _displayedMeals = widget._availableMeals.where((_meal) {
        return _meal.categories.contains(_categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle as String),
      ),
      body: ListView.builder(
        itemBuilder: (_ctx, _index) {
          return MealItem(
            id: _displayedMeals[_index].id,
            title: _displayedMeals[_index].title,
            imageUrl: _displayedMeals[_index].imageUrl,
            duration: _displayedMeals[_index].duration,
            affordability: _displayedMeals[_index].affordability,
            complexity: _displayedMeals[_index].complexity,
          );
        },
        itemCount: _displayedMeals.length,
      ),
    );
  }
}
