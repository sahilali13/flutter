import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';
import '../providers/orders_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var _themeData = ThemeData(
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
      fontFamily: 'Lato',
    );

    var _routes = {
      ProductDetailScreen.routeName: (_ctx) => const ProductDetailScreen(),
      CartScreen.routeName: (_ctx) => const CartScreen(),
      OrdersScreen.routeName: (_ctx) => const OrdersScreen(),
      UserProductsScreen.routeName: (_ctx) => const UserProductsScreen(),
    };

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_ctx) => OrdersProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: _themeData,
        home: const ProductsOverviewScreen(),
        routes: _routes,
      ),
    );
  }
}
