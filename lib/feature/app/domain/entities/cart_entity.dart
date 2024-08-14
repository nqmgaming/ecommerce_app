class CartEntity {
  final String id;
  final String userId;
  final String productId;
  final String productName;
  final String productImage;
  final int productPrice;
  final int categoryId;
  final String categoryName;
  final int quantity;
  final String size;
  final String color;
  final DateTime createdAt;

  CartEntity({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.categoryId,
    required this.categoryName,
    required this.quantity,
    required this.size,
    required this.color,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}