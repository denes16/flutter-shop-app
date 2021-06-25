import 'package:flutter/cupertino.dart';
import 'cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts) {
    final double total = cartProducts.fold(
        0, (previousValue, element) => previousValue + element.price);
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().millisecond.toString(),
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
