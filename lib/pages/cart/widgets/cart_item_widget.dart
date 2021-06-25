import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem _cartItem;
  CartItemWidget(this._cartItem);

  @override
  Widget build(BuildContext context) {
    var _cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Dismissible(
      key: ValueKey(_cartItem.id),
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to remove?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('No')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Yes'))
                  ],
                ));
      },
      onDismissed: (_) {
        _cartProvider.removeItem(_cartItem.id);
      },
      direction: DismissDirection.endToStart,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: Text('${_cartItem.title}'),
            subtitle: Text('\$${_cartItem.price * _cartItem.quatity}'),
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: FittedBox(child: Text('\$${_cartItem.price}')),
              ),
            ),
            trailing: Text('${_cartItem.quatity} x'),
          ),
        ),
      ),
    );
  }
}
