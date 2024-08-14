import 'package:ecommerce_app/feature/app/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel({
    required super.userId,
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.productPrice,
    required super.categoryId,
    required super.categoryName,
    required super.quantity,
    required super.size,
    required super.color,
    required String id,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      productImage: map['productImage'] as String,
      productPrice: map['productPrice'] as int,
      categoryId: map['categoryId'] as int,
      categoryName: map['categoryName'] as String,
      quantity: map['quantity'] as int,
      size: map['size'] as String,
      color: map['color'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }
}
