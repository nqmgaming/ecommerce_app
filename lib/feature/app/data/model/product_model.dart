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
}
