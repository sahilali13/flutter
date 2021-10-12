import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String _id;
  final String _title;
  final String _imageUrl;

  const UserProductItem({
    Key? key,
    required id,
    required title,
    required imageUrl,
  })  : _id = id,
        _imageUrl = imageUrl,
        _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: _id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<Products>(context, listen: false)
                    .deleteProduct(_id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
