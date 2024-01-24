abstract class KeyValueStorageService {
  Future<void> setKeyValue(String key, dynamic value);
  Future<void> getValue(String key, dynamic value);
  Future<bool> removeKey(String key);
}
