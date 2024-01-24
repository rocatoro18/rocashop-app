abstract class KeyValueStorageService {
  // T ES UN TIPO DE DATO GENERICO, QUE TRATA A LA INFORMACION A COMO SE RECIBA
  Future<void> setKeyValue<T>(String key, T value);
  Future<T?> getValue<T>(String key);
  Future<bool> removeKey(String key);
}
