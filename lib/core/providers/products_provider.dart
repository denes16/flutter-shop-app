import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _allProducts = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  var _showOnlyFavorites = false;
  List<Product> get allProducts {
    return [..._allProducts];
  }

  final _url =
      'https://flutter-shop-a2af9-default-rtdb.firebaseio.com/products';
  final _baseUrl = Uri.parse(
      'https://flutter-shop-a2af9-default-rtdb.firebaseio.com/products.json');
  Future<void> fetchProducts() async {
    try {
      final response = await Dio().get(_baseUrl.toString());
      _allProducts = [];
      (response.data as Map).forEach((prodId, value) {
        print(value);
        _allProducts.add(Product.fromJson({...value, 'id': prodId}));
      });
      notifyListeners();
      print(_allProducts);
    } catch (e) {
      print(e);
    }
  }

  Future<void> addProcuct(Product product) async {
    final url = _baseUrl;
    var newProduct = product.copyWith(id: DateTime.now().toIso8601String());
    var response = await http.post(url, body: json.encode(newProduct.toJson()));
    _allProducts
        .add(newProduct.copyWith(id: json.decode(response.body)['name']));
    notifyListeners();
  }

  getProductById(String id) {
    return this._allProducts.firstWhere((element) => element.id == id);
  }

  deleteProduct(String id) {
    this._allProducts.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    try {
      final body = product.toJson();
      body.remove('id');
      final response = await Dio()
          .patch('${_url.toString()}/${product.id}.json', data: body);
      print(response.data);
      final i = _allProducts.indexWhere((element) => element.id == product.id);
      if (i != -1) {
        _allProducts[i] = product.copyWith();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
