import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
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
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${_cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6!.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: _cart)
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _cart.items.length,
              itemBuilder: (_ctx, _index) => CartItem(
                quantity: _cart.items.values.toList()[_index].quantity,
                id: _cart.items.values.toList()[_index].id,
                productId: _cart.items.keys.toList()[_index],
                title: _cart.items.values.toList()[_index].title,
                price: _cart.items.values.toList()[_index].price,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required Cart cart,
  })  : _cart = cart,
        super(key: key);

  final Cart _cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading
          ? const CircularProgressIndicator.adaptive()
          : const Text('ORDER NOW'),
      onPressed: (widget._cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget._cart.items.values.toList(),
                widget._cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget._cart.clear();
            },
      style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)),
    );
  }
}
