import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/providers/products_provider.dart';
import '../../core/providers/cart_provider.dart';
import '../cart/cart_screen.dart';
import '../../shared/widgets/badge.dart';
import '../../shared/widgets/main_drawer.dart';
import 'products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _isLoading = false;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchProducts()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Denes Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.All) {
                setState(() {
                  _showOnlyFavorites = false;
                });
              }
              if (selectedValue == FilterOptions.Favorites) {
                setState(() {
                  _showOnlyFavorites = true;
                });
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              )
            ],
          ),
          Consumer<CartProvider>(
            builder: (_, cartProvider, child) =>
                Badge(child: child, value: cartProvider.totalItems.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
