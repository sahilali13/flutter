import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsPage extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> _availableMeals;
  const CategoryMealsPage(this._availableMeals, {Key? key}) : super(key: key);

  @override
  State<CategoryMealsPage> createState() => _CategoryMealsPageState();
}

class _CategoryMealsPageState extends State<CategoryMealsPage> {
  late String _categoryId;
  late List<Meal> _categoryMeals;
  late String _categoryTitle;

  @override
  void didChangeDependencies() {
    var _modalRouteContext = ModalRoute.of(context)!;
    final _routeArgs =
        _modalRouteContext.settings.arguments as Map<String, String>;
    _categoryTitle = _routeArgs['title'] as String;
    _categoryId = _routeArgs['id'] as String;
    _categoryMeals = widget._availableMeals.where(
      (_meal) {
        return _meal.categories.contains(
          _categoryId,
        );
      },
    ).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String _mealID) {
    setState(() {
      _categoryMeals.removeWhere((_meal) => _meal.id == _mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          removeItem: _removeMeal,
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
