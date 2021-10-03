import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _modalRouteContext = ModalRoute.of(context)!;
    var _productsProviderContext = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );

    final _productId = _modalRouteContext.settings.arguments as String;

    final _loadedProduct = _productsProviderContext.findById(
      _productId,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _loadedProduct.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                _loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '₹${_loadedProduct.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                _loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
