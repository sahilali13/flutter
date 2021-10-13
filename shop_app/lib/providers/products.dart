import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
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

  Future<void> updateProduct(String _id, Product _newProduct) async {
    final _prodIndex = _items.indexWhere((_prod) => _prod.id == _id);
    if (_prodIndex >= 0) {
      try {
        final _url = Uri.parse(
          'https://flutter-update-b8d2b-default-rtdb.firebaseio.com/products/$_id.json',
        );
        await http.patch(
          _url,
          body: json.encode({
            'title': _newProduct.title,
            'description': _newProduct.description,
            'imageUrl': _newProduct.imageUrl,
            'price': _newProduct.price,
          }),
        );
        _items[_prodIndex] = _newProduct;
        notifyListeners();
      } catch (_error) {
        rethrow;
      }
    } else {}
  }

  Future<void> deleteProduct(String _id) async {
    final _url = Uri.parse(
      'https://flutter-update-b8d2b-default-rtdb.firebaseio.com/products/$_id.json',
    );
    final _existingProductIndex = _items.indexWhere((prod) => prod.id == _id);
    Product? _existingProduct = _items[_existingProductIndex];
    _items.removeAt(_existingProductIndex);
    notifyListeners();
    final response = await http.delete(_url);
    if (response.statusCode >= 400) {
      _items.insert(_existingProductIndex, _existingProduct);
      notifyListeners();
      throw HttpException(message: 'Could not delete product.');
    }
    _existingProduct = null;
  }

  Future<void> fetchAndSetProducts() async {
    final _url = Uri.parse(
      'https://flutter-update-b8d2b-default-rtdb.firebaseio.com/products.json',
    );
    try {
      final _response = await http.get(_url);
      final _extractedData =
          json.decode(_response.body) as Map<String, dynamic>;
      // ignore: unnecessary_null_comparison
      if (_extractedData == null) {
        return;
      }
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
