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
  @JsonKey(required: true, defaultValue: [])
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    try {
      final response = await Dio().get(
          'https://flutter-shop-a2af9-default-rtdb.firebaseio.com/orders.json');
      final List<OrderItem> newOrders = [];
      for (var item
          in ((response.data ?? {}) as Map<String, dynamic>).entries) {
        final newOrder = OrderItem.fromJson({...item.value, 'id': item.key});
        newOrders.add(newOrder);
      }
      _orders = newOrders.reversed.toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
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
