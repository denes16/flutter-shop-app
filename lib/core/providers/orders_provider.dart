import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'cart_provider.dart';
import 'package:json_annotation/json_annotation.dart';
part 'orders_provider.g.dart';

@JsonSerializable()
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

  static fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts) async {
    final double total = cartProducts.fold(
        0, (previousValue, element) => previousValue + element.price);
    final item = OrderItem(
        amount: total, products: cartProducts, dateTime: DateTime.now());
    try {
      await Dio().post(
          'https://flutter-shop-a2af9-default-rtdb.firebaseio.com/orders.json',
          data: jsonEncode(item.toJson()));
      _orders.insert(0, item);
      notifyListeners();
    } catch (e) {}
  }
}
