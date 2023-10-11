part of 'utilities.dart';

class LocalStore {
  LocalStore(this._storage);

  final FlutterSecureStorage _storage;

  Future<bool> keyExists(String key) async {
    return await _storage.containsKey(key: key);
  }

  Future<String> getKey(String key) async {
    return await _storage.read(key: key) ?? "";
  }

  void setKey(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  void deleteKey(String key) async {
    await _storage.delete(key: key);
  }
}