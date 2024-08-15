import 'package:ecommerce_app/feature/app/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.id,
    required super.content,
    required super.fullName,
    required super.profileImage,
    required super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      content: json['content'],
      fullName: json['fullName'],
      profileImage: json['profileImage'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'fullName': fullName,
      'profileImage': profileImage,
      'createdAt': createdAt,
    };
  }
}
