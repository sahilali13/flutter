import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _themeContext = Theme.of(context);
    ProductProvider _product =
        Provider.of<ProductProvider>(context, listen: false);
    CartProvider _cart = Provider.of<CartProvider>(context, listen: false);
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
          leading: Consumer<ProductProvider>(
            builder: (_ctx, _product, _) => IconButton(
              onPressed: () {
                _product.toggleFavouriteStatus();
              },
              icon: Icon(
                  _product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: _themeContext.colorScheme.secondary,
            ),
          ),
          title: Text(
            _product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          trailing: IconButton(
            onPressed: () {
              _cart.addItemToCart(
                _product.id,
                _product.price,
                _product.title,
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Item Added',
                  ),
                  duration: const Duration(
                    seconds: 2,
                  ),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () => _cart.removeSingleItem(
                      _product.id,
                    ),
                  ),
                ),
              );
            },
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
