// lib/core/services/storage_service.dart
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

  // Theme related methods
  bool get isDarkMode => read('dark_mode') ?? false;

  void setDarkMode(bool value) {
    write('dark_mode', value);
  }

  // Auth related methods
  String? get token => read('token');

  void setToken(String token) {
    write('token', token);
  }

  bool get isLoggedIn => token != null && token.toString().isNotEmpty;

  // User data
  Map<String, dynamic>? get userData => read('user_data');

  void setUserData(Map<String, dynamic> data) {
    write('user_data', data);
  }

  // Clear all except theme preference
  void clearAll() {
    final darkMode = isDarkMode;
    clear();
    setDarkMode(darkMode);
  }
}
