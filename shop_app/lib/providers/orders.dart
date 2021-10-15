// ignore_for_file: unnecessary_null_comparison

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
  final String? _authToken;
  final String? _userId;

  Orders(this._authToken, this._userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final _url = Uri.https('flutter-update-b8d2b-default-rtdb.firebaseio.com',
        '/orders/$_userId.json?auth=$_authToken');
    final _response = await http.get(_url);
    final List<OrderItem> _loadedOrders = [];
    final _extractedData = json.decode(_response.body) as Map<String, dynamic>;
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
                  price: _item['price'],
                  quantity: _item['quantity'],
                  title: _item['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = _loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> _cartProducts, double _total) async {
    final _url = Uri.https('flutter-update-b8d2b-default-rtdb.firebaseio.com',
        '/orders/$_userId.json?auth=$_authToken');
    final _timestamp = DateTime.now();
    final response = await http.post(
      _url,
      body: json.encode({
        'amount': _total,
        'dateTime': _timestamp.toIso8601String(),
        'products': _cartProducts
            .map((_cp) => {
                  'id': _cp.id,
                  'title': _cp.title,
                  'quantity': _cp.quantity,
                  'price': _cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: _total,
        dateTime: _timestamp,
        products: _cartProducts,
      ),
    );
    notifyListeners();
  }
}
