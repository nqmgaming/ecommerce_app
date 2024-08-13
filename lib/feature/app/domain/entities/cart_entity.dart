import 'package:ecommerce_app/feature/app/data/model/cart_model.dart';

class CartEntity {
  final String id;
  final String userId;
  final String productId;
  final int quantity;
  final String size;
  final String color;

  const CartEntity({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.size,
    required this.color,
  });
}
