import 'package:flutter/material.dart';

class CartProviderItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartProviderItem({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartProviderItem> items = {};

  Map<String, CartProviderItem> get itemGetter {
    return {...items};
  }

  int get itemCount {
    return items.length;
  }

  double get totalAmount {
    var _total = 0.0;
    items.forEach((_key, _cartItem) {
      _total += _cartItem.price * _cartItem.quantity;
    });
    return _total;
  }

  void addItemToCart(
    String _productId,
    double _price,
    String _title,
  ) {
    if (items.containsKey(_productId)) {
      items.update(
        _productId,
        (_existingCartItem) => CartProviderItem(
          id: _existingCartItem.id,
          price: _existingCartItem.price,
          quantity: _existingCartItem.quantity + 1,
          title: _existingCartItem.title,
        ),
      );
    } else {
      items.putIfAbsent(
        _productId,
        () => CartProviderItem(
          id: DateTime.now().toString(),
          price: _price,
          quantity: 1,
          title: _title,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String _id) {
    items.remove(_id);
    notifyListeners();
  }

  void removeSingleItem(String _productId) {
    if (!items.containsKey(_productId)) {
      return;
    }
    if (items[_productId]!.quantity > 1) {
      items.update(
        _productId,
        (_existingCartItem) => CartProviderItem(
          id: _existingCartItem.id,
          price: _existingCartItem.price,
          quantity: _existingCartItem.quantity - 1,
          title: _existingCartItem.title,
        ),
      );
    } else {
      items.remove(_productId);
    }
    notifyListeners();
  }

  void clear() {
    items = {};
    notifyListeners();
  }
}
