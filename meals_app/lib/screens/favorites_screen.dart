import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;

  const FavoritesScreen({Key? key, required List<Meal> favoriteMeals})
      : _favoriteMeals = favoriteMeals,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_favoriteMeals.isEmpty) {
      return const Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (_ctx, _index) {
          return MealItem(
            id: _favoriteMeals[_index].id,
            title: _favoriteMeals[_index].title,
            imageUrl: _favoriteMeals[_index].imageUrl,
            duration: _favoriteMeals[_index].duration,
            affordability: _favoriteMeals[_index].affordability,
            complexity: _favoriteMeals[_index].complexity,
          );
        },
        itemCount: _favoriteMeals.length,
      );
    }
  }
}
