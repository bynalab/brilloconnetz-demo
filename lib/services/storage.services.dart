import 'package:get_storage/get_storage.dart';

class StorageService {
  static Future<void> writeToGetStorage(String key, value) async {
    final box = GetStorage();

    await box.write(key, value);
  }

  static readFromGetStorage(String key) {
    final box = GetStorage();

    return box.read(key);
  }

  static removeFromGetStorage(String key) {
    final box = GetStorage();

    return box.remove(key);
  }
}
