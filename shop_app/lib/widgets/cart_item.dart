import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String _id;
  final double _price;
  final int _quantity;
  final String _title;
  final String _productId;

  const CartItem({
    Key? key,
    required id,
    required price,
    required quantity,
    required title,
    required productId,
  })  : _id = id,
        _price = price,
        _quantity = quantity,
        _title = title,
        _productId = productId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(_id),
      background: Container(
          color: Theme.of(context).errorColor,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(
            right: 20,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          )),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text(
                    '₹$_price',
                  ),
                ),
              ),
            ),
            title: Text(_title),
            subtitle: Text('Total: ₹${(_price * _quantity)}'),
            trailing: Text('$_quantity x'),
          ),
        ),
      ),
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false)
            .removeItem(_productId);
      },
    );
  }
}
