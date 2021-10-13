import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavoriteValue(bool _newValue) {
    isFavorite = _newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final _oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final _url = Uri.parse(
        'https://flutter-update-b8d2b-default-rtdb.firebaseio.com/products/$id.json',
      );
      final _response = await http.patch(
        _url,
        body: json.encode(
          {
            'isFavorite': isFavorite,
          },
        ),
      );
      if (_response.statusCode >= 400) {
        _setFavoriteValue(_oldStatus);
      }
    } catch (_error) {
      _setFavoriteValue(_oldStatus);
    }
  }
}
