import 'package:flutter/material.dart';

import '../pages/category_meals_page.dart';

class CategoryItem extends StatelessWidget {
  final String _id;
  final String _title;
  final Color _color;

  // ignore: use_key_in_widget_constructors
  const CategoryItem(
    this._id,
    this._title,
    this._color,
  );

  void selectCategory(BuildContext _ctx) {
    Navigator.of(_ctx).pushNamed(
      CategoryMealsPage.routeName,
      arguments: {
        'id': _id,
        'title': _title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _themeContext = Theme.of(context);

    var _boxDecoration = BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _color.withOpacity(0.7),
          _color,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15),
    );

    var _child = Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        _title,
        style: _themeContext.textTheme.headline6,
      ),
      decoration: _boxDecoration,
    );

    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: _themeContext.primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: _child,
    );
  }
}
