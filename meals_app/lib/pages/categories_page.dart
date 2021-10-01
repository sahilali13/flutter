import 'package:flutter/material.dart';

import '../widgets/category_item.dart';
import '../data/dummy_data.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _body = GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      children: dummyCategories
          .map(
            (_data) => CategoryItem(
              _data.id,
              _data.title,
              _data.color,
            ),
          )
          .toList(),
    );

    return _body;
  }
}
