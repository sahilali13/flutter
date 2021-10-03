import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart';

import '../screens/cart_screen.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';

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
