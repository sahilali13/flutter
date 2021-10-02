import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../providers/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get itemGetter {
    return [..._items];
  }

  List<Product> get favoriteItemsGetter {
    return _items.where((_item) => _item.isFavourite).toList();
  }

  Product findById(String _id) {
    return _items.firstWhere((_product) => _product.id == _id);
  }

  void addPoducts() {
    notifyListeners();
  }
}
