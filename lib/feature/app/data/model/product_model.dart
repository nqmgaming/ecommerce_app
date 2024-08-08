import 'package:ecommerce_app/feature/app/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.images,
    required super.creationAt,
    required super.updatedAt,
    required super.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      images: json['images'],
      creationAt: json['creationAt'],
      updatedAt: json['updatedAt'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'title': super.title,
      'price': super.price,
      'description': super.description,
      'images': super.images,
      'creationAt': super.creationAt,
      'updatedAt': super.updatedAt,
      'category': super.category,
    };
  }
}
