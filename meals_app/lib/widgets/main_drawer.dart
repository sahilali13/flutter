import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget _buildListTile(
    IconData _icon,
    String _title,
  ) {
    return ListTile(
      leading: Icon(
        _icon,
        size: 26,
      ),
      title: Text(
        _title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed-Bold',
          fontSize: 24,
        ),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    var _themeContext = Theme.of(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: _themeContext.colorScheme.secondary,
            child: Text(
              'Cooking Up',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: _themeContext.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildListTile(
            Icons.restaurant,
            'Meals',
          ),
          _buildListTile(
            Icons.settings,
            'Filter',
          ),
        ],
      ),
    );
  }
}
