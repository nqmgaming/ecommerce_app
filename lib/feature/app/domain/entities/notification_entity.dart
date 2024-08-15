class NotificationEntity {
  final String id;
  final String userId;
  final String content;
  final String fullName;
  final String profileImage;
  final String createdAt;

  NotificationEntity({
    required this.id,
    required this.userId,
    required this.content,
    required this.fullName,
    required this.profileImage,
    required this.createdAt,
  });
}
