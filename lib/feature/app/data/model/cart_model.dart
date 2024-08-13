import 'package:ecommerce_app/feature/app/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel({
    required super.id,
    required super.userId,
    required super.productId,
    required super.quantity,
    required super.size,
    required super.color,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      productId: map['productId'] as String,
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
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }
}
