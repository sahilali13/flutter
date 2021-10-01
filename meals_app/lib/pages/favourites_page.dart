import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouritesPage extends StatelessWidget {
  final List<Meal> _favouriteMeals;

  const FavouritesPage(this._favouriteMeals, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_favouriteMeals.isEmpty) {
      return const Center(
        child: Text(
          'No favourites yet!!!',
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (_ctx, _index) {
          return MealItem(
            id: _favouriteMeals[_index].id,
            affordability: _favouriteMeals[_index].affordability,
            complexity: _favouriteMeals[_index].complexity,
            duration: _favouriteMeals[_index].duration,
            imageUrl: _favouriteMeals[_index].imageUrl,
            title: _favouriteMeals[_index].title,
          );
        },
        itemCount: _favouriteMeals.length,
      );
    }
  }
}
