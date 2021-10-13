import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

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
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> _cartProducts, double _total) async {
    final _url = Uri.parse(
      'https://flutter-update-b8d2b-default-rtdb.firebaseio.com/orders.json',
    );
    final _timestamp = DateTime.now();
    final _response = await http.post(
      _url,
      body: json.encode(
        {
          'amount': _total,
          'dateTime': _timestamp.toIso8601String(),
          'products': _cartProducts
              .map((_cartProduct) => {
                    'id': _cartProduct.id,
                    'price': _cartProduct.price,
                    'quantity': _cartProduct.quantity,
                    'title': _cartProduct.title,
                  })
              .toList(),
        },
      ),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(_response.body)['name'],
        amount: _total,
        dateTime: _timestamp,
        products: _cartProducts,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    final _url = Uri.parse(
      'https://flutter-update-b8d2b-default-rtdb.firebaseio.com/orders.json',
    );
    final _response = await http.get(_url);
    final List<OrderItem> _loadedOrders = [];
    final _extractedData = json.decode(_response.body) as Map<String, dynamic>;
    // ignore: unnecessary_null_comparison
    if (_extractedData == null) {
      return;
    }
    _extractedData.forEach((_orderId, _orderData) {
      _loadedOrders.add(
        OrderItem(
          id: _orderId,
          amount: _orderData['amount'],
          dateTime: DateTime.parse(_orderData['dateTime']),
          products: (_orderData['products'] as List<dynamic>)
              .map(
                (_item) => CartItem(
                  id: _item['id'],
                  title: _item['title'],
                  quantity: _item['quantity'],
                  price: _item['price'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = _loadedOrders.reversed.toList();
    notifyListeners();
  }
}
