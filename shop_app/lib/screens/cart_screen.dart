import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart';

import '../widgets/cart_item.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<CartProvider>(context);
    var _body = Column(
      children: <Widget>[
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    '${_cart.totalAmount}',
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.headline6!.color,
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<OrdersProvider>(context, listen: false)
                        .addOrder(
                            cartProducts: _cart.items.values.toList(),
                            total: _cart.totalAmount);
                    _cart.clear();
                  },
                  child: const Text(
                    'ORDER NOW',
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (_ctx, _index) {
              var _cartKeys = _cart.items.keys.toList();
              var _cartValues = _cart.items.values.toList();
              return CartItem(
                productId: _cartKeys[_index],
                id: _cartValues[_index].id,
                price: _cartValues[_index].price,
                quantity: _cartValues[_index].quantity,
                title: _cartValues[_index].title,
              );
            },
            itemCount: _cart.items.length,
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
        ),
      ),
      body: _body,
    );
  }
}
