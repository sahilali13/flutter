import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function _saveFilters;
  final Map<String, bool?> _currentFilters;

  const FiltersScreen({Key? key, required currentFilters, required saveFilters})
      : _currentFilters = currentFilters,
        _saveFilters = saveFilters,
        super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool? _glutenFree = false;
  bool? _vegetarian = false;
  bool? _vegan = false;
  bool? _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget._currentFilters['gluten'];
    _lactoseFree = widget._currentFilters['lactose'];
    _vegetarian = widget._currentFilters['vegetarian'];
    _vegan = widget._currentFilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTile({
    required String title,
    required String description,
    required bool? currentValue,
    required void Function(bool)? updateValue,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue as bool,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              Map<String, bool?> _selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget._saveFilters(filterData: _selectedFilters);
            },
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  title: 'Gluten-free',
                  description: 'Only include gluten-free meals.',
                  currentValue: _glutenFree,
                  updateValue: (_newValue) {
                    setState(
                      () {
                        _glutenFree = _newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  title: 'Lactose-free',
                  description: 'Only include lactose-free meals.',
                  currentValue: _lactoseFree,
                  updateValue: (_newValue) {
                    setState(
                      () {
                        _lactoseFree = _newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  title: 'Vegetarian',
                  description: 'Only include vegetarian meals.',
                  currentValue: _vegetarian,
                  updateValue: (_newValue) {
                    setState(
                      () {
                        _vegetarian = _newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  title: 'Vegan',
                  description: 'Only include vegan meals.',
                  currentValue: _vegan,
                  updateValue: (_newValue) {
                    setState(
                      () {
                        _vegan = _newValue;
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
