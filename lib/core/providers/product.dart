import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});
  void toggleFavoriteStatus() {
    Dio().patch(
        'https://flutter-shop-a2af9-default-rtdb.firebaseio.com/products/${this.id}.json',
        data: {'isFavorite': !isFavorite}).catchError((_) {
      isFavorite = !isFavorite;
      notifyListeners();
    });
    isFavorite = !isFavorite;
    notifyListeners();
  }

  static fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith(
      {String id,
      String title,
      String description,
      String imageUrl,
      double price,
      bool isFavorite}) {
    return Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl);
  }
}
