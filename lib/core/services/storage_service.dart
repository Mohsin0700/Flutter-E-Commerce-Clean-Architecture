import 'package:get/get.dart';

class StorageService extends GetxService {
  final Map<String, dynamic> _storage = {};

  Future<StorageService> init() async {
    // Initialize local storage (SharedPreferences in real app)
    return this;
  }

  void write(String key, dynamic value) {
    _storage[key] = value;
  }

  dynamic read(String key) {
    return _storage[key];
  }

  void remove(String key) {
    _storage.remove(key);
  }

  void clear() {
    _storage.clear();
  }
}
