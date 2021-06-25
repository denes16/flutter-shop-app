import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/providers/orders_provider.dart' as p;

final currencyFormatter = new NumberFormat.currency();

class OrderItemHeader extends StatelessWidget {
  final p.OrderItem _order;
  OrderItemHeader(this._order);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(currencyFormatter.format(_order.amount)),
            subtitle: Text(DateFormat.yMMMEd().format(_order.dateTime)),
          )
        ],
      ),
    );
  }
}
