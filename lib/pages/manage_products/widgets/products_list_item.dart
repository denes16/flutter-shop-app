import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/providers/product.dart';
import 'package:shop/core/providers/products_provider.dart';
import 'package:shop/pages/edit_product/edit_product_screen.dart';

class ProductListItem extends StatelessWidget {
  final Product _product;
  ProductListItem(this._product);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,
                    arguments: _product);
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {
                Provider.of<ProductsProvider>(context, listen: false)
                    .deleteProduct(_product.id);
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
