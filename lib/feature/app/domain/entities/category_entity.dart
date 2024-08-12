import 'package:flutter/material.dart';

class CategoryEntity {
  final int id;
  final String name;
  final String image;
  final String creationAt;
  final String updatedAt;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  IconData get icon {
    switch (name.toLowerCase()) {
      case 'clothes':
        return Icons.checkroom;
      case 'electronics':
        return Icons.electrical_services;
      case 'furniture':
        return Icons.chair;
      case 'shoes':
        return Icons.shopping_bag;
      case 'miscellaneous':
        return Icons.category;
      case 'jugueticos':
        return Icons.toys;
      case 'frutas':
        return Icons.local_grocery_store;
      default:
        return Icons.help_outline;
    }
  }

}
