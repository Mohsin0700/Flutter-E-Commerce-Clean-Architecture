import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/data/repositories/auth_repository.dart';

import '../../data/models/user_model.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  bool get isLoggedIn => currentUser.value != null;
  bool get isAdmin => currentUser.value?.isAdmin ?? false;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      final user = await _authRepository.login(email, password);
      if (user != null) {
        currentUser.value = user;
        if (user.isAdmin) {
          Get.offAllNamed(AppRoutes.ADMIN_DASHBOARD);
        } else {
          Get.offAllNamed(AppRoutes.HOME);
        }
      } else {
        Get.snackbar('Error', 'Invalid credentials');
      }
    } catch (e) {
      Get.snackbar('Error', 'Login failed');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password, String name) async {
    isLoading.value = true;
    try {
      final user = await _authRepository.register(email, password, name);
      if (user != null) {
        currentUser.value = user;
        Get.offAllNamed(AppRoutes.HOME);
      }
    } catch (e) {
      Get.snackbar('Error', 'Registration failed');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    currentUser.value = null;
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
