import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/cart_provider.dart';
import '../../core/providers/orders_provider.dart';
import 'widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  static var routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    var _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Total',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: Chip(
                        backgroundColor: Theme.of(context).primaryColor,
                        label: Text(
                          '\$${_cartProvider.totalAmount}',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .color),
                        )),
                  ),
                  Expanded(
                      child: Center(
                    child: TextButton(
                        onPressed: () {
                          Provider.of<OrdersProvider>(context, listen: false)
                              .addOrder(_cartProvider.items.values.toList());
                          _cartProvider.clear();
                        },
                        child: Text('ORDER NOW')),
                  ))
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _cartProvider.totalItems,
                  itemBuilder: (ctx, i) =>
                      CartItemWidget(_cartProvider.items.values.toList()[i])))
        ],
      ),
    );
  }
}
