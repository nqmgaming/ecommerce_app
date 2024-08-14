class UserEntity {
  final int? id;
  final String? email;
  final String? name;
  final String? role;
  final String? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? assetToken;
  final String? refreshToken;

  UserEntity({
    this.id,
    this.email,
    this.name,
    this.role,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.assetToken,
    this.refreshToken,
  });
}
