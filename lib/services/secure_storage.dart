import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> save(String token, String role) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'role', value: role);
  }

  Future<String?> getToken() => _storage.read(key: 'token');
  Future<String?> getRole() => _storage.read(key: 'role');
  Future<void> clear() => _storage.deleteAll();
}

final storage = SecureStorage();
