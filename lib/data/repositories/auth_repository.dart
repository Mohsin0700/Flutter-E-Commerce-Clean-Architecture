import 'package:imr/data/models/user_model.dart';

class AuthRepository {
  Future<UserModel?> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    if (email == 'admin@admin.com' && password == 'admin123') {
      return UserModel(
        id: '1',
        email: email,
        name: 'Admin User',
        phone: '+1234567890',
        isAdmin: true,
        createdAt: DateTime.now(),
      );
    } else if (email == 'user@user.com' && password == 'user123') {
      return UserModel(
        id: '2',
        email: email,
        name: 'Regular User',
        phone: '+1234567890',
        isAdmin: false,
        createdAt: DateTime.now(),
      );
    }
    return null;
  }

  Future<UserModel?> register(
    String email,
    String password,
    String name,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    return UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      isAdmin: false,
      createdAt: DateTime.now(),
    );
  }

  Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 500));
  }

  Future<bool> resetPassword(String email) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }
}
