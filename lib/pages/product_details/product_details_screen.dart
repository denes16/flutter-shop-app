import 'package:flutter/material.dart';

import '../../core/providers/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product';
  @override
  Widget build(BuildContext context) {
    final Product _product =
        ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(_product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: Image.network(
                _product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '\$${_product.price}',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Text(
              _product.description,
              textAlign: TextAlign.center,
              softWrap: true,
            )),
          ],
        ),
      ),
    );
  }
}
