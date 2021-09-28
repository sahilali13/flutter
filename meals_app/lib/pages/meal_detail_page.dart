import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class MealDetailPage extends StatelessWidget {
  static const routeName = './Meal-Detail';

  const MealDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _modalRouteContext = ModalRoute.of(context)!;
    final _mealId = _modalRouteContext.settings.arguments as String;
    final _meal = dummyMeals.where(
      (_meal) {
        return _meal.id.compareTo(_mealId) == 0;
      },
    ).toList()[0];

    var _appBar = AppBar(
      title: Text(
        _meal.title,
      ),
    );

    const _body = Center(
      child: Text(
        'Dope',
      ),
    );

    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }
}
