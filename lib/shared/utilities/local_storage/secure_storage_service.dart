import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static final SecureStorageHelper _instance = SecureStorageHelper._internal();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  SecureStorageHelper._internal();

  static SecureStorageHelper get instance => _instance;

  /// Saves a string value securely.
  Future<void> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Retrieves a securely stored string value.
  Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  /// Deletes a stored value securely.
  Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }

  /// Clears all stored data (Use with caution).
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
