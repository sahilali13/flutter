import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../providers/orders_provider.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem _order;

  const OrderItem({Key? key, required ord.OrderItem order})
      : _order = order,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('₹${_order.amount}'),
            subtitle:
                Text(DateFormat('dd-MM-yyyy hh:mm').format(_order.dateTime)),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.expand)),
          ),
        ],
      ),
    );
  }
}
