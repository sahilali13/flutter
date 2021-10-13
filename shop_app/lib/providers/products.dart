import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../data/dummy_data.dart';
import '../providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((_prodItem) => _prodItem.isFavorite).toList();
  }

  Product findById(String _id) {
    return _items.firstWhere((_prod) => _prod.id == _id);
  }

  Future<void> addProduct(Product _product) async {
    final _url = Uri.parse(
      'https://flutter-update-b8d2b-default-rtdb.firebaseio.com/products.json',
    );
    try {
      final _response = await http.post(
        _url,
        body: json.encode({
          "title": _product.title,
          "description": _product.description,
          'price': _product.price,
          'imageUrl': _product.imageUrl,
          'isFavorite': _product.isFavorite,
        }),
      );
      final _newProduct = Product(
        title: _product.title,
        description: _product.description,
        price: _product.price,
        imageUrl: _product.imageUrl,
        id: json.decode(_response.body)['name'],
      );
      _items.add(_newProduct);
      notifyListeners();
    } catch (_error) {
      rethrow;
    }
  }

  void updateProduct(String _id, Product _newProduct) {
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

  Future<void> fetchAndSetProducts() async {
    final _url = Uri.parse(
      'https://flutter-update-b8d2b-default-rtdb.firebaseio.com/products.json',
    );
    try {
      final _response = await http.get(_url);
      final _extractedData =
          json.decode(_response.body) as Map<String, dynamic>;
      final List<Product> _loadedProducts = [];
      _extractedData.forEach((_prodId, _prodData) {
        _loadedProducts.add(
          Product(
            id: _prodId,
            title: _prodData['title'],
            description: _prodData['description'],
            price: _prodData['price'],
            imageUrl: _prodData['imageUrl'],
            isFavorite: _prodData['isFavorite'],
          ),
        );
        _items = _loadedProducts;
        notifyListeners();
      });
    } catch (_error) {
      rethrow;
    }
  }
}
