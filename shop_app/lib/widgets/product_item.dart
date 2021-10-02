import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _themeContext = Theme.of(context);
    Product _product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: _product.id,
            );
          },
          child: Image.network(
            _product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (_ctx, _product, _) => IconButton(
              onPressed: () {
                _product.toggleFavouriteStatus();
              },
              icon: Icon(_product.isFavourite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: _themeContext.colorScheme.secondary,
            ),
          ),
          title: Text(
            _product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart,
            ),
            color: _themeContext.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
