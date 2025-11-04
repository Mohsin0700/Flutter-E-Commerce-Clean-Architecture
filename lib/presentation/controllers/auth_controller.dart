import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/core/constants/app_constants.dart';
import 'package:imr/core/services/storage_service.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/user_model.dart';
import 'package:imr/data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final StorageService _storageService = Get.find();

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  bool get isLoggedIn => currentUser.value != null;
  bool get isAdmin => currentUser.value?.isAdmin ?? false;

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
  }

  void _loadUserFromStorage() {
    final userData = _storageService.read(AppConstants.USER_KEY);
    if (userData != null) {
      currentUser.value = UserModel.fromJson(userData);
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      final user = await _authRepository.login(email, password);
      if (user != null) {
        currentUser.value = user;
        _storageService.write(AppConstants.USER_KEY, user.toJson());

        if (user.isAdmin) {
          Get.offAllNamed(AppRoutes.ADMIN_DASHBOARD);
        } else {
          Get.offAllNamed(AppRoutes.HOME);
        }
        Helpers.showSnackbar('Success', 'Welcome back, ${user.name}!');
      } else {
        Helpers.showSnackbar('Error', 'Invalid credentials', isError: true);
      }
    } catch (e) {
      Helpers.showSnackbar('Error', 'Login failed', isError: true);
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
        _storageService.write(AppConstants.USER_KEY, user.toJson());
        Get.offAllNamed(AppRoutes.HOME);
        Helpers.showSnackbar('Success', 'Account created successfully!');
      }
    } catch (e) {
      Helpers.showSnackbar('Error', 'Registration failed', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email) async {
    isLoading.value = true;
    try {
      await _authRepository.resetPassword(email);
      Helpers.showSnackbar('Success', 'Password reset link sent to your email');
      Get.back();
    } catch (e) {
      Helpers.showSnackbar('Error', 'Failed to send reset link', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    currentUser.value = null;
    _storageService.remove(AppConstants.USER_KEY);
    Get.offAllNamed(AppRoutes.LOGIN);
    Helpers.showSnackbar('Success', 'Logged out successfully');
  }

  Future<void> updateProfile(UserModel user) async {
    currentUser.value = user;
    _storageService.write(AppConstants.USER_KEY, user.toJson());
    Helpers.showSnackbar('Success', 'Profile updated successfully');
  }
}
