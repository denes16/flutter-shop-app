import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/providers/auth_provider.dart';
import 'package:shop/pages/auth/auth_screen.dart';
import 'package:shop/pages/edit_product/edit_product_screen.dart';
import 'package:shop/pages/manage_products/manage_products_screen.dart';
import 'core/providers/orders_provider.dart';
import 'pages/cart/cart_screen.dart';
import 'pages/orders/orders_screen.dart';
import 'core/providers/cart_provider.dart';
import 'core/providers/products_provider.dart';
import 'pages/product_details/product_details_screen.dart';
import 'pages/products_overview/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: AuthScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          ManageProductsScreen.routeName: (ctx) => ManageProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
        },
      ),
    );
  }
}
