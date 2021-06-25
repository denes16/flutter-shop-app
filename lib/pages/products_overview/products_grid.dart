import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/products_provider.dart';
import '../../shared/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool _showOnlyFavs;
  ProductsGrid(this._showOnlyFavs);
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final _products = productsProvider.allProducts
        .where((element) => _showOnlyFavs ? element.isFavorite : true)
        .toList();
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20),
        itemCount: _products.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: _products[i], child: ProductItem()));
  }
}
