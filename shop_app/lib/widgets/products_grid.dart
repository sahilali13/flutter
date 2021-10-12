import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool _showFavs;

  const ProductsGrid({Key? key, required showFavs})
      : _showFavs = showFavs,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productsData = Provider.of<Products>(context);
    final _products =
        _showFavs ? _productsData.favoriteItems : _productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: _products.length,
      itemBuilder: (_ctx, _index) => ChangeNotifierProvider.value(
        value: _products[_index],
        child: const ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
