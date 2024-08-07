import 'package:ecommerce_app/feature/auth/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel({
    super.id,
    super.email,
    super.name,
    super.role,
    super.avatar,
    super.createdAt,
    super.updatedAt,
    super.assetToken,
    super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      avatar: json['avatar'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      assetToken: json['asset_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }
}
