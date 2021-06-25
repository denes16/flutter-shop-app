import 'package:flutter/cupertino.dart';
import 'product.dart';

class CartItem {
  final String id;
  final String title;
  final int quatity;
  final double price;
  CartItem({this.id, this.title, this.quatity, this.price});
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get totalItems {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += (value.price * value.quatity);
    });
    return total;
  }

  void removeItem(String productId) {
    _items.removeWhere((key, value) => key == productId);
    notifyListeners();
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quatity: value.quatity + 1,
              price: value.price));
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
              id: product.id,
              title: product.title,
              quatity: 1,
              price: product.price));
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quatity > 1) {
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              price: value.price,
              quatity: value.quatity - 1,
              title: value.title));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
