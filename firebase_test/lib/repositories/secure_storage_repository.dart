import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final secureStorageRepositoryProvider =
    Provider((ref) => SecureStorageRepository());

class SecureStorageRepository {
  /// Factory constractor
  factory SecureStorageRepository() {
    return _repository;
  }

  /// private constructor
  SecureStorageRepository._() : _secureStorage = const FlutterSecureStorage();

  /// This class instance.
  static final _repository = SecureStorageRepository._();

  /// Storage instance
  final FlutterSecureStorage _secureStorage;

  /// A key for saving / reading / deleting access token.
  static const _userIdKey = 'userId';

  /// save [idToken] in secure storage.
  Future<void> saveUserId(String idToken) async {
    await _secureStorage.write(key: _userIdKey, value: idToken);
  }

  /// Read id token from secure storage.
  Future<String?> readUserId() async {
    return _secureStorage.read(key: _userIdKey);
  }

  /// Delete userId items from secure storage.
  Future<void> deleteUserId() async {
    await _secureStorage.delete(key: _userIdKey);
  }

  /// Delete All items from secure storage.
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
}
