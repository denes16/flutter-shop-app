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
                    child: SubmitOrderButton(cartProvider: _cartProvider),
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

class SubmitOrderButton extends StatefulWidget {
  const SubmitOrderButton({
    @required CartProvider cartProvider,
  }) : _cartProvider = cartProvider;

  final CartProvider _cartProvider;

  @override
  _SubmitOrderButtonState createState() => _SubmitOrderButtonState();
}

class _SubmitOrderButtonState extends State<SubmitOrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget._cartProvider.totalAmount == 0 || _isLoading
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<OrdersProvider>(context, listen: false)
                    .addOrder(widget._cartProvider.items.values.toList());
                _isLoading = false;
                widget._cartProvider.clear();
              },
        child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'));
  }
}
