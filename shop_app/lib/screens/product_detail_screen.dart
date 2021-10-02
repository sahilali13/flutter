import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-detail';
  const ProductDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _modalRouteContext = ModalRoute.of(context)!;
    final _productId = _modalRouteContext.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _productId,
        ),
      ),
    );
  }
}
