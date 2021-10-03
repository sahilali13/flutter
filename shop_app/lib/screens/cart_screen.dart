import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  label: Consumer<CartProvider>(
                      builder: (_, _cartTotal, __) => Text(
                            '${_cartTotal.totalAmount}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6!
                                  .color,
                            ),
                          )),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                TextButton(
                  onPressed: () {},
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
          child: Consumer<CartProvider>(
            builder: (_, _cart, __) => ListView.builder(
                itemBuilder: (_ctx, _index) {
                  var _cartList = _cart.items.values.toList();
                  return CartItem(
                    id: _cartList[_index].id,
                    price: _cartList[_index].price,
                    quantity: _cartList[_index].quantity,
                    title: _cartList[_index].title,
                  );
                },
                itemCount: _cart.items.length),
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
