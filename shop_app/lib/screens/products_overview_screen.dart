import 'package:flutter/material.dart';

import '../widgets/product_item.dart';
import '../data/dummy_data.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final _loadedProducts = dummyProducts;
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop App',
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: _loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (_ctx, _index) => ProductItem(
          imageUrl: _loadedProducts[_index].imageUrl,
          title: _loadedProducts[_index].title,
          id: _loadedProducts[_index].id,
        ),
      ),
    );
  }
}
