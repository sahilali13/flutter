import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get itemGetter {
    return [..._items];
  }

  void addProduct() {
    //_items.add();
    notifyListeners();
  }
}
