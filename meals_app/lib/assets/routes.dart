import 'package:flutter/material.dart';

import '../pages/categories_page.dart';
import '../pages/category_meals_page.dart';
import '../pages/meal_detail_page.dart';

Map<String, WidgetBuilder> get routes {
  return {
    '/': (_ctx) => const CategoriesPage(),
    CategoryMealsPage.routeName: (_ctx) => const CategoryMealsPage(),
    MealDetailPage.routeName: (_ctx) => const MealDetailPage(),
  };
}
