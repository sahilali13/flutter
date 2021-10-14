import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final double price;
  final String? imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool _newValue) {
    isFavorite = _newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String? _token, String? _userId) async {
    final _oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final _url = Uri.https('flutter-update-b8d2b-default-rtdb.firebaseio.com/',
        '/userFavorites/$_userId/$id.json?auth=$_token');
    try {
      final _response = await http.put(
        _url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (_response.statusCode >= 400) {
        _setFavValue(_oldStatus);
      }
    } catch (_error) {
      _setFavValue(_oldStatus);
    }
  }
}
