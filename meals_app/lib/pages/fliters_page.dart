import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersPage extends StatefulWidget {
  static const routeName = '/filters-page';
  // ignore: prefer_typing_uninitialized_variables
  final _saveFilters;
  // ignore: prefer_typing_uninitialized_variables
  final _filters;

  const FiltersPage(this._filters, this._saveFilters, {Key? key})
      : super(key: key);
  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget._filters['gluten'];
    _lactoseFree = widget._filters['lactose'];
    _vegan = widget._filters['vegan'];
    _vegetarian = widget._filters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(
    bool _flag,
    String _title,
    String _description,
    void Function(bool)? _updateValue,
  ) {
    final _themeContext = Theme.of(context);
    return SwitchListTile.adaptive(
      activeColor: _themeContext.colorScheme.primary,
      value: _flag,
      onChanged: _updateValue,
      title: Text(
        _title,
      ),
      subtitle: Text(
        _description,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _themeContext = Theme.of(context);
    var _appBar = AppBar(
      title: const Text('Filters'),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            final _selectedFilters = {
              'gluten': _glutenFree,
              'vegetarian': _vegetarian,
              'vegan': _vegan,
              'lactose': _lactoseFree,
            };
            widget._saveFilters(_selectedFilters);
          },
          icon: const Icon(
            Icons.save,
          ),
        ),
      ],
    );
    var _body = Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Filter your meals',
            style: _themeContext.textTheme.headline6,
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              _buildSwitchListTile(
                _glutenFree,
                "Gluten-Free",
                "Only include gluten-free meals",
                (_newValue) {
                  setState(() {
                    _glutenFree = _newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                _vegetarian,
                'Vegetarian',
                'Only show vegetarian meals',
                (_newValue) {
                  setState(() {
                    _vegetarian = _newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                _vegan,
                'Vegan',
                'Only show vegan meals',
                (_newValue) {
                  setState(() {
                    _vegan = _newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                _lactoseFree,
                'Lactose-Free',
                'Only show lactose-free meals',
                (_newValue) {
                  setState(() {
                    _lactoseFree = _newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: _appBar,
      drawer: const MainDrawer(),
      body: _body,
    );
  }
}
