import 'package:flutter/material.dart';
import 'package:shop/core/providers/orders_provider.dart';

class OrderItemBody extends StatelessWidget {
  final OrderItem _order;
  OrderItemBody(this._order);
  Widget buildProductRow(int index) {
    var product = _order.products[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          product.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text('${product.price} * ${product.quatity}'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 100,
      child: ListView.builder(
          itemCount: _order.products.length,
          itemBuilder: (ctx, i) => buildProductRow(i)),
      margin: EdgeInsets.all(10),
    );
  }
}
