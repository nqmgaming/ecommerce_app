import 'package:ecommerce_app/feature/app/data/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';

class CartDao {
  final Database _database;

  CartDao(this._database);

  Future<void> insertCart(CartModel cartModel) async {
    await _database.insert('Cart', {
      'id': cartModel.id,
      'userId': cartModel.userId,
      'productId': cartModel.productId,
      'quantity': cartModel.quantity,
      'size': cartModel.size,
      'color': cartModel.color,
      'productName': cartModel.productName,
      'productImage': cartModel.productImage,
      'productPrice': cartModel.productPrice,
      'categoryId': cartModel.categoryId,
      'categoryName': cartModel.categoryName,
      'createdAt': cartModel.createdAt.millisecondsSinceEpoch,
    });
  }

  Future<void> updateCart(String id, int quantity) async {
    await _database.update(
      'Cart',
      {
        'quantity': quantity,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteCart(String id) async {
    print('delete cart');
    await _database.delete(
      'Cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllCart(String userId) async {
    print('delete all cart');
    await _database.delete(
      'Cart',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<List<Map<String, dynamic>>> getAllCartByUser(String userId) async {
    final response = await _database.query(
      'Cart',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return response;
  }

  Future<Map<String, dynamic>?> getCartByProductIdSizeColor(String userId, String productId, String size, String color) async {
    final response = await _database.query(
      'Cart',
      where: 'userId = ? AND productId = ? AND size = ? AND color = ?',
      whereArgs: [userId, productId, size, color],
    );
    if (response.isNotEmpty) {
      return response.first;
    }
    return null;
  }
}