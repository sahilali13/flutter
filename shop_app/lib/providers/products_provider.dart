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

  void addProducts() {
    notifyListeners();
  }
}
