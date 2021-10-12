import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var _total = 0.0;
    _items.forEach((_key, _cartItem) {
      _total += _cartItem.price * _cartItem.quantity;
    });
    return _total;
  }

  void addItem(
    String _productId,
    double _price,
    String _title,
  ) {
    if (_items.containsKey(_productId)) {
      // change quantity...
      _items.update(
        _productId,
        (_existingCartItem) => CartItem(
          id: _existingCartItem.id,
          title: _existingCartItem.title,
          price: _existingCartItem.price,
          quantity: _existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        _productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: _title,
          price: _price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String _productId) {
    _items.remove(_productId);
    notifyListeners();
  }

  void removeSingleItem(String _productId) {
    if (!_items.containsKey(_productId)) {
      return;
    }
    if (_items[_productId]!.quantity > 1) {
      _items.update(
          _productId,
          (_existingCartItem) => CartItem(
                id: _existingCartItem.id,
                title: _existingCartItem.title,
                price: _existingCartItem.price,
                quantity: _existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(_productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
