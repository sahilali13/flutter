import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class MealDetailPage extends StatelessWidget {
  static const routeName = './meal-detail';
  // ignore: prefer_typing_uninitialized_variables
  final _toggleFavourite;
  // ignore: prefer_typing_uninitialized_variables
  final _isMealFavourite;
  const MealDetailPage(this._toggleFavourite, this._isMealFavourite, {Key? key})
      : super(key: key);

  Widget _buildSectionTitle(
    String _txt,
    ThemeData _themeContext,
    MediaQueryData _mediaQueryContext,
    AppBar _appBar,
  ) {
    return Container(
      height: (_mediaQueryContext.size.height -
              _appBar.preferredSize.height -
              _mediaQueryContext.padding.top) *
          0.05,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        _txt,
        style: _themeContext.textTheme.headline6,
      ),
    );
  }

  Widget _buildSectionContainer(
    ThemeData _themeContext,
    MediaQueryData _mediaQueryContext,
    AppBar _appBar,
    Widget _child,
  ) {
    return Container(
      height: (_mediaQueryContext.size.height -
              _appBar.preferredSize.height -
              _mediaQueryContext.padding.top) *
          0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      width: 300,
      child: _child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var _modalRouteContext = ModalRoute.of(context)!;
    var _themeContext = Theme.of(context);
    var _mediaQueryContext = MediaQuery.of(context);

    final _mealId = _modalRouteContext.settings.arguments as String;
    final _selectedMeal = dummyMeals.firstWhere(
      (_meal) {
        return _meal.id.compareTo(_mealId) == 0;
      },
    );

    var _appBar = AppBar(
      title: Text(
        _selectedMeal.title,
      ),
    );

    var _body = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: (_mediaQueryContext.size.height -
                    _appBar.preferredSize.height -
                    _mediaQueryContext.padding.top) *
                0.3,
            width: double.infinity,
            child: Image.network(
              _selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          _buildSectionTitle(
            'Ingredients',
            _themeContext,
            _mediaQueryContext,
            _appBar,
          ),
          _buildSectionContainer(
            _themeContext,
            _mediaQueryContext,
            _appBar,
            ListView.builder(
              itemBuilder: (_ctx, _index) => Card(
                color: _themeContext.colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Text(
                    _selectedMeal.ingredients[_index],
                  ),
                ),
              ),
              itemCount: _selectedMeal.ingredients.length,
            ),
          ),
          _buildSectionTitle(
            'Steps',
            _themeContext,
            _mediaQueryContext,
            _appBar,
          ),
          _buildSectionContainer(
            _themeContext,
            _mediaQueryContext,
            _appBar,
            ListView.builder(
              itemCount: _selectedMeal.steps.length,
              itemBuilder: (_ctx, _index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        '${(_index + 1)}',
                      ),
                    ),
                    title: Text(
                      _selectedMeal.steps[_index],
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    var _floatingActionButton = FloatingActionButton(
      onPressed: () => _toggleFavourite(_mealId),
      child: Icon(
        _isMealFavourite(_mealId) ? Icons.star : Icons.star_border,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
    return Scaffold(
      appBar: _appBar,
      body: _body,
      floatingActionButton: _floatingActionButton,
    );
  }
}
