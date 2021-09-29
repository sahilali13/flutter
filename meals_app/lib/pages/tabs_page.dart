import 'package:flutter/material.dart';

import '../pages/categories_page.dart';
import '../pages/favourites_page.dart';
import '../widgets/main_drawer.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final List<Map<String, Object>> _pages = const [
    {
      'title': 'Categories',
      'page': CategoriesPage(),
    },
    {
      'page': FavouritesPage(),
      'title': "Favourite",
    },
  ];
  int _selectedPageIndex = 0;

  void _selectedPage(int _index) {
    setState(() {
      _selectedPageIndex = _index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _themeContext = Theme.of(context);

    var _bottomNavigationBar = BottomNavigationBar(
      backgroundColor: _themeContext.colorScheme.primary,
      unselectedItemColor: Colors.white,
      selectedItemColor: _themeContext.colorScheme.secondary,
      currentIndex: _selectedPageIndex,
      type: BottomNavigationBarType.shifting,
      onTap: _selectedPage,
      items: [
        BottomNavigationBarItem(
          backgroundColor: _themeContext.colorScheme.primary,
          icon: const Icon(
            Icons.category,
          ),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          backgroundColor: _themeContext.colorScheme.primary,
          icon: const Icon(
            Icons.favorite,
          ),
          label: 'Favourite',
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'] as String,
        ),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      drawer: const MainDrawer(),
      bottomNavigationBar: _bottomNavigationBar,
    );
  }
}
