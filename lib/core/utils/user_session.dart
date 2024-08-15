import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class UserSession {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String> getUserId() async {
    final userId = await _secureStorage.read(key: 'userId');
    return userId ?? '';
  }

  Future<String> getName() async {
    final userName = await _secureStorage.read(key: 'name');
    return userName ?? '';
  }

  Future<String> getAvatar() async {
    final userAvatar = await _secureStorage.read(key: 'avatar');
    return userAvatar ?? '';
  }

  Future<String> getEmail() async {
    final userEmail = await _secureStorage.read(key: 'email');
    return userEmail ?? '';
  }

  Future<void> clearUserData() async {
    await _secureStorage.deleteAll();
  }
}
