import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String _imageUrl;
  final String _title;
  final String _id;

  const ProductItem({
    required imageUrl,
    required title,
    required id,
    Key? key,
  })  : _imageUrl = imageUrl,
        _title = title,
        _id = id,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var _themeContext = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: _id,
            );
          },
          child: Image.network(
            _imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
            ),
            color: _themeContext.colorScheme.secondary,
          ),
          title: Text(
            _title,
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
