import 'package:flutter/material.dart';

import '../widgets/products_overview_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _appBar = AppBar(
      title: const Text(
        'Shop App',
      ),
    );
    return Scaffold(
      appBar: _appBar,
      body: const ProductsOverviewGrid(),
    );
  }
}
