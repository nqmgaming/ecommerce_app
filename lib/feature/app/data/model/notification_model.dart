import 'package:ecommerce_app/feature/app/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.id,
    required super.content,
    required super.userId,
    required super.fullName,
    required super.profileImage,
    required super.createdAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['userId'],
      content: json['content'],
      fullName: json['fullName'],
      profileImage: json['profileImage'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'fullName': fullName,
      'profileImage': profileImage,
      'createdAt': createdAt,
    };
  }
}
