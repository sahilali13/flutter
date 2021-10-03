import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';
import '../providers/cart_provider.dart';
import '../widgets/badge.dart';
import '../widgets/products_overview_grid.dart';

enum _filterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    var _appBar = AppBar(
      title: const Text(
        'Shop App',
      ),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: (_filterOptions _selectedValue) {
            setState(() {
              if (_selectedValue == _filterOptions.favorites) {
                _showFavorites = true;
              } else {
                _showFavorites = false;
              }
            });
          },
          itemBuilder: (_) => [
            const PopupMenuItem(
              child: Text(
                'Only Favorites',
              ),
              value: _filterOptions.favorites,
            ),
            const PopupMenuItem(
              child: Text(
                'Show All',
              ),
              value: _filterOptions.all,
            ),
          ],
          icon: const Icon(
            Icons.more_vert,
          ),
        ),
        Consumer<CartProvider>(
          builder: (_, _cart, _childIcon) => Badge(
            child: _childIcon,
            value: _cart.itemCount.toString(),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: _appBar,
      body: ProductsOverviewGrid(
        showFavorites: _showFavorites,
      ),
    );
  }
}
