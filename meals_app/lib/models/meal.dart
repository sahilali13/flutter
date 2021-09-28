enum Complexity {
  simple,
  challenging,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}

class Meal {
  late final String id;
  late final List<String> categories;
  late final String title;
  late final String imageUrl;
  late final List<String> ingredients;
  late final List<String> steps;
  late final int duration;
  late final Complexity complexity;
  late final Affordability affordability;
  late final bool isGlutenFree;
  late final bool isLactoseFree;
  late final bool isVegan;
  late final bool isVegetarian;

  Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });
}
