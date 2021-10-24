import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_route.dart';

import '../providers/products.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../providers/auth.dart';

import '../screens/splash_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/products_overview_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/auth_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products('', '', []),
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders('', '', []),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Colors.purple),
            primarySwatch: Colors.purple,
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
          ).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  secondary: Colors.deepOrange,
                ),
          ),
          home: auth.isAuth
              ? const ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (_ctx) =>
                const ProductDetailScreen(),
            CartScreen.routeName: (_ctx) => const CartScreen(),
            OrdersScreen.routeName: (_ctx) => const OrdersScreen(),
            UserProductsScreen.routeName: (_ctx) => const UserProductsScreen(),
            EditProductScreen.routeName: (_ctx) => const EditProductScreen(),
          },
        ),
      ),
    );
  }
}
