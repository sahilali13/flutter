import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function _toggleFavorite;
  final Function _isFavorite;

  const MealDetailScreen(
      {Key? key, required toggleFavorite, required isFavorite})
      : _toggleFavorite = toggleFavorite,
        _isFavorite = isFavorite,
        super(key: key);

  Widget buildSectionTitle({
    required BuildContext context,
    required String text,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer({
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _mealId = ModalRoute.of(context)!.settings.arguments as String;
    final _selectedMeal =
        DUMMY_MEALS.firstWhere((_meal) => _meal.id == _mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                _selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context: context, text: 'Ingredients'),
            buildContainer(
              child: ListView.builder(
                itemBuilder: (_ctx, _index) => Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(_selectedMeal.ingredients[_index])),
                ),
                itemCount: _selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context: context, text: 'Steps'),
            buildContainer(
              child: ListView.builder(
                itemBuilder: (_ctx, _index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(_index + 1)}'),
                      ),
                      title: Text(
                        _selectedMeal.steps[_index],
                      ),
                    ),
                    const Divider()
                  ],
                ),
                itemCount: _selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          _isFavorite(id: _mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => _toggleFavorite(mealId: _mealId),
      ),
    );
  }
}
