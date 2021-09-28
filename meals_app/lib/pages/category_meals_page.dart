import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../data/dummy_data.dart';

class CategoryMealsPage extends StatelessWidget {
  static const routeName = '/category-meals';

  const CategoryMealsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _modalRouteContext = ModalRoute.of(context)!;

    final _routeArgs =
        _modalRouteContext.settings.arguments as Map<String, String>;

    final _categoryTitle = _routeArgs['title'] as String;
    final _categoryId = _routeArgs['id'] as String;
    final _categoryMeals = dummyMeals.where(
      (_meal) {
        return _meal.categories.contains(
          _categoryId,
        );
      },
    ).toList();

    var _appBar = AppBar(
      title: Text(
        _categoryTitle,
      ),
    );

    var _body = ListView.builder(
      itemBuilder: (_ctx, _index) {
        return MealItem(
          id: _categoryMeals[_index].id,
          affordability: _categoryMeals[_index].affordability,
          complexity: _categoryMeals[_index].complexity,
          duration: _categoryMeals[_index].duration,
          imageUrl: _categoryMeals[_index].imageUrl,
          title: _categoryMeals[_index].title,
        );
        // Text(
        //   _categoryMeals[_index].title,
        // );
      },
      itemCount: _categoryMeals.length,
    );

    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }
}
