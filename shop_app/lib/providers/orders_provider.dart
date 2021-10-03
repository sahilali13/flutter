import 'package:flutter/material.dart';

import '../providers/cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartProviderItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.dateTime,
    required this.products,
  });
}

class OrdersProvider with ChangeNotifier {
  final List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(
      {required List<CartProviderItem> cartProducts, required double total}) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
  }
}
