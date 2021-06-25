import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/providers/products_provider.dart';
import 'package:shop/pages/edit_product/edit_product_screen.dart';
import 'package:shop/pages/manage_products/widgets/products_list_item.dart';
import 'package:shop/shared/widgets/main_drawer.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/manage-products';
  @override
  Widget build(BuildContext context) {
    final _productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: MainDrawer(),
      body: RefreshIndicator(
        onRefresh: () {
          return _productsProvider.fetchProducts();
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: _productsProvider.allProducts.length,
              itemBuilder: (_, i) => Column(children: [
                    ProductListItem(_productsProvider.allProducts[i]),
                    Divider()
                  ])),
        ),
      ),
    );
  }
}
