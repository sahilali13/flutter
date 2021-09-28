import 'package:flutter/material.dart';

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

    var _appBar = AppBar(
      title: Text(
        _categoryTitle,
      ),
    );

    var _body = Center(
      child: Text(
        _categoryId,
      ),
    );

    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }
}
