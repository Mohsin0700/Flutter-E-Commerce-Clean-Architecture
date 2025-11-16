import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/core/constants/app_constants.dart';
import 'package:imr/core/services/storage_service.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/user_model.dart';
import 'package:imr/data/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    _listenToAuthChanges(); // Email verification ke liye listener
  }

  void _loadUserFromStorage() {
    final userData = _storageService.read(AppConstants.USER_KEY);
    if (userData != null) {
      currentUser.value = UserModel.fromJson(userData);
    }
  }

  /// Listen to auth state changes for email verification
  void _listenToAuthChanges() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      print('Auth event: ${data.event}');
      print('Session user: ${data.session?.user.email}');
      print('Email confirmed at: ${data.session?.user.emailConfirmedAt}');

      if (data.event == AuthChangeEvent.signedIn) {
        final user = data.session?.user;

        // Check if email is verified
        if (user != null && user.emailConfirmedAt != null) {
          print('Email verified! Logging in user...');

          // Create UserModel and save
          final userModel = UserModel(
            id: user.id,
            email: user.email!,
            name: user.userMetadata?['name'] ?? 'User',
            isAdmin: user.userMetadata?['isAdmin'] ?? false,
            createdAt: DateTime.parse(user.createdAt),
          );

          currentUser.value = userModel;
          _storageService.write(AppConstants.USER_KEY, userModel.toJson());

          // Navigate based on role
          if (userModel.isAdmin) {
            Get.offAllNamed(AppRoutes.ADMIN_DASHBOARD);
          } else {
            Get.offAllNamed(AppRoutes.MAIN);
          }

          Helpers.showSnackbar(
            'Success',
            'Email verified! Welcome, ${userModel.name}!',
          );
        }
      }
    });
  }

  Future<void> login(String email, String password) async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final user = await _authRepository.login(email, password);

      if (user != null) {
        currentUser.value = user;
        _storageService.write(AppConstants.USER_KEY, user.toJson());

        // Navigate based on user role
        if (user.isAdmin) {
          Get.offAllNamed(AppRoutes.ADMIN_DASHBOARD);
        } else {
          Get.offAllNamed(AppRoutes.MAIN);
        }

        Helpers.showSnackbar('Success', 'Welcome back, ${user.name}!');
      }
    } on AuthException catch (e) {
      print('AuthException caught in controller: $e');

      // Handle specific cases that need special UI treatment
      if (e.statusCode == '400' &&
          (e.message.toLowerCase().contains('email not confirmed') ||
              e.message.toLowerCase().contains('email_not_confirmed'))) {
        _showEmailVerificationDialog(email);
      }
      // Other errors are already handled by repository's _handleAuthException
    } catch (e) {
      print('Unexpected error in login controller: $e');
      // Generic errors are already handled by repository
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password, String name) async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final user = await _authRepository.register(email, password, name);

      if (user != null) {
        // Don't store user or navigate to main - they need to verify email first
        // Just navigate to login page
        Get.offAllNamed(AppRoutes.LOGIN);

        // Success message is already shown in repository
      }
    } on AuthException catch (e) {
      print('AuthException caught in register: $e');
      // Errors are already handled by repository
    } catch (e) {
      print('Unexpected error in register: $e');
      // Errors are already handled by repository
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email) async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final success = await _authRepository.resetPassword(email);

      if (success) {
        Helpers.showSnackbar(
          'Success',
          'Password reset link sent to your email',
        );
        Get.back();
      }
    } catch (e) {
      print('Error in reset password: $e');
      // Errors are already handled by repository
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      currentUser.value = null;
      _storageService.remove(AppConstants.USER_KEY);
      Get.offAllNamed(AppRoutes.LOGIN);
      Helpers.showSnackbar('Success', 'Logged out successfully');
    } catch (e) {
      print('Error during logout: $e');
      // Force logout even if there's an error
      currentUser.value = null;
      _storageService.remove(AppConstants.USER_KEY);
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  Future<void> updateProfile(UserModel user) async {
    currentUser.value = user;
    _storageService.write(AppConstants.USER_KEY, user.toJson());
    Helpers.showSnackbar('Success', 'Profile updated successfully');
  }

  /// Show dialog for email verification with option to resend
  void _showEmailVerificationDialog(String email) {
    Get.dialog(
      AlertDialog(
        title: const Text('Email Verification Required'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please verify your email address to continue.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Check your inbox at:\n$email',
              style: TextStyle(
                fontSize: 14,
                color: Get.theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('OK')),
          TextButton(
            onPressed: () {
              Get.back();
              _resendVerificationEmail(email);
            },
            child: const Text('Resend Email'),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  /// Resend verification email
  Future<void> _resendVerificationEmail(String email) async {
    try {
      await Supabase.instance.client.auth.resend(
        type: OtpType.signup,
        email: email,
      );

      Helpers.showSnackbar(
        'Success',
        'Verification email sent! Please check your inbox.',
      );
    } on AuthException catch (e) {
      print('Error resending verification email: $e');
      Helpers.showSnackbar(
        'Error',
        'Failed to resend verification email. Please try again later.',
        isError: true,
      );
    } catch (e) {
      print('Unexpected error resending email: $e');
      Helpers.showSnackbar(
        'Error',
        'An unexpected error occurred.',
        isError: true,
      );
    }
  }
}
