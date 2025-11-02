import 'package:imr/data/models/user_model.dart';

class AuthRepository {
  Future<UserModel?> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    // Mock login - replace with actual API
    if (email == 'admin@admin.com' && password == 'admin') {
      return UserModel(
        id: '1',
        email: email,
        name: 'Admin User',
        isAdmin: true,
      );
    } else if (email == 'user@user.com' && password == 'user') {
      return UserModel(
        id: '2',
        email: email,
        name: 'Regular User',
        isAdmin: false,
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
    );
  }

  Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 500));
  }
}
