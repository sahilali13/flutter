import 'package:flutter/material.dart';
import 'dart:math';

import 'package:intl/intl.dart';

import '../providers/orders_provider.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem _order;

  const OrderItem({Key? key, required ord.OrderItem order})
      : _order = order,
        super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    var _listProducts = widget._order.products;
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('₹${widget._order.amount}'),
            subtitle: Text(DateFormat('dd MMM, yyyy   hh:mm')
                .format(widget._order.dateTime)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
              ),
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: min(_listProducts.length * 20.0 + 50, 150),
              child: ListView.builder(
                itemBuilder: (_ctx, _index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _listProducts[_index].title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_listProducts[_index].quantity} x ₹${_listProducts[_index].price}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                itemCount: _listProducts.length,
              ),
            )
        ],
      ),
    );
  }
}
