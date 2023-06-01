part of 'utilities.dart';

class LocalStore {
  final _storage = const FlutterSecureStorage();

  Future<bool> keyExists(String key) async {
    return await _storage.containsKey(key: key);
  }

  Future<String> getKey(String key) async {
    return await _storage.read(key: key) ?? "";
  }

  void setKey(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
}