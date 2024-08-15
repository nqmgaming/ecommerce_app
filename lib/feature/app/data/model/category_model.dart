import 'package:ecommerce_app/feature/app/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.name,
    required super.image,
    required super.creationAt,
    required super.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      creationAt: json['creationAt'] ,
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'image': super.image,
      'creationAt': super.creationAt,
      'updatedAt': super.updatedAt,
    };
  }

}
