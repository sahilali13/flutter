import 'package:flutter/foundation.dart';

import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> _cartProducts, double _total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: _total,
        dateTime: DateTime.now(),
        products: _cartProducts,
      ),
    );
    notifyListeners();
  }
}
