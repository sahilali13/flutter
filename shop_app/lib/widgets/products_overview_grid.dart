import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductsOverviewGrid extends StatelessWidget {
  final bool _showFavorites;

  const ProductsOverviewGrid({
    required showFavorites,
    Key? key,
  })  : _showFavorites = showFavorites,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productsProviderContext = Provider.of<ProductsProvider>(context);

    final _products = _showFavorites
        ? _productsProviderContext.favoriteItemsGetter
        : _productsProviderContext.itemGetter;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: _products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_ctx, _index) => ChangeNotifierProvider.value(
        value: _products[_index],
        child: const ProductItem(),
      ),
    );
  }
}
