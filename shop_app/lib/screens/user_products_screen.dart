import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products_provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productsData = Provider.of<ProductsProvider>(context).itemGetter;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemBuilder: (_ctx, _index) => Column(
            children: [
              UserProductItem(
                title: _productsData[_index].title,
                imageUrl: _productsData[_index].imageUrl,
                id: _productsData[_index].id,
              ),
              const Divider(),
            ],
          ),
          itemCount: _productsData.length,
        ),
      ),
    );
  }
}
