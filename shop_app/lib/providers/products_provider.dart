import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../providers/product_provider.dart';

class ProductsProvider with ChangeNotifier {
  final List<ProductProvider> _items = dummyProducts;

  List<ProductProvider> get itemGetter {
    return [..._items];
  }

  List<ProductProvider> get favoriteItemsGetter {
    return _items.where((_item) => _item.isFavorite).toList();
  }

  ProductProvider findById(String _id) {
    return _items.firstWhere((_product) => _product.id == _id);
  }

  void addProducts(ProductProvider _product) {
    final _newProduct = ProductProvider(
      description: _product.description,
      id: DateTime.now().toString(),
      imageUrl: _product.imageUrl,
      price: _product.price,
      title: _product.title,
    );
    _items.add(_newProduct);
    notifyListeners();
  }

  void updateProduct(String _id, ProductProvider _newProduct) {
    final _prodIndex = _items.indexWhere((_prod) => _prod.id == _id);
    if (_prodIndex >= 0) {
      _items[_prodIndex] = _newProduct;
      notifyListeners();
    } else {}
  }

  void deleteProduct(String _id) {
    _items.removeWhere((_prod) => _prod.id == _id);
    notifyListeners();
  }
}
