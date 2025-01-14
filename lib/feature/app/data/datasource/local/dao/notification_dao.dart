import 'package:ecommerce_app/feature/app/data/model/notification_model.dart';
import 'package:sqflite/sqflite.dart';

class NotificationDao {
  final Database _database;

  NotificationDao(this._database);

  Future<bool> insertNotification(NotificationModel notification) async {
    final db = _database;
    final result = await db.insert(
      'Notification',
      {
        'id': notification.id,
        'userId': notification.userId,
        'content': notification.content,
        'fullName': notification.fullName,
        'profileImage': notification.profileImage,
        'isRead': 0,
        'createdAt': notification.createdAt.toString(),
      },
    );
    return result > 0;
  }

  Future<List<Map<String, dynamic>>> getAllNotifications(String userId) async {
    final response = await _database.query(
      'Notification',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );
    return response;
  }

  Future<bool> deleteNotification(String id) async {
    final db = _database;
    final result = await db.delete(
      'Notification',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result > 0;
  }

  Future<bool> readNotification(String id) async {
    final db = _database;
    final result = await db.update(
      'Notification',
      {'isRead': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
    return result > 0;
  }
}
