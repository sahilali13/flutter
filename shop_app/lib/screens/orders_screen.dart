import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders_provider.dart' show OrdersProvider;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _orderData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemBuilder: (_ctx, _index) =>
            OrderItem(order: _orderData.orders[_index]),
        itemCount: _orderData.orders.length,
      ),
    );
  }
}
