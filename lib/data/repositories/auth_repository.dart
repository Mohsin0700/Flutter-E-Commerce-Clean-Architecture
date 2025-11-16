import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final supabase = Supabase.instance.client;

  Future<UserModel?> login(String email, String password) async {
    print('Login Function called from Auth Repo');
    try {
      final response = await supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );

      print(
        'Login Response From Auth Repo ::::::::::::::::::::::::::::${response.user}',
      );

      if (response.user != null) {
        return UserModel(
          id: response.user!.id,
          email: email,
          name: response.user?.userMetadata?['name'] ?? "New User",
          isAdmin: response.user?.userMetadata?['isAdmin'] ?? false,
          createdAt: DateTime.parse(response.user!.createdAt.toString()),
        );
      }
    } on AuthException catch (e) {
      print('Auth Exception from auth repo ::::::::::::::::::::::::: $e');
      _handleAuthException(e);
      rethrow; // Rethrow to let controller handle navigation
    } catch (e) {
      print('Unexpected error in login: $e');
      Helpers.showSnackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        isError: true,
      );
      rethrow;
    }
    return null;
  }

  Future<UserModel?> register(
    String email,
    String password,
    String name,
  ) async {
    print('Registration function called from repository');
    try {
      final response = await supabase.auth.signUp(
        password: password,
        email: email,
        data: {'name': name, 'isAdmin': false},
        emailRedirectTo:
            'com.yourcompany.yourapp://login-callback/', // IMPORTANT: Apna package name yahan daal dena
      );

      print('Response from auth repo ::::::::::::::::::::::::: $response');
      print(
        'Response user from auth repo ::::::::::::::::::::::::: ${response.user}',
      );

      if (response.user != null) {
        // Show success message with email verification prompt
        Helpers.showSnackbar(
          'Success',
          'Account created! Please check your email to verify your account.',
        );

        return UserModel(
          id: response.user!.id,
          email: response.user!.email!,
          name: name,
          isAdmin: false,
          createdAt: DateTime.parse(response.user!.createdAt),
        );
      }
    } on AuthException catch (e) {
      print('Auth Exception from auth repo ::::::::::::::::::::::::: $e');
      _handleAuthException(e);
      rethrow;
    } catch (e) {
      print('Unexpected error in register: $e');
      Helpers.showSnackbar(
        'Error',
        'Registration failed. Please try again.',
        isError: true,
      );
      rethrow;
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      print('Error during logout: $e');
      // Still allow logout even if Supabase fails
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
      return true;
    } on AuthException catch (e) {
      print('Auth Exception in reset password: $e');
      _handleAuthException(e);
      return false;
    } catch (e) {
      print('Unexpected error in reset password: $e');
      Helpers.showSnackbar(
        'Error',
        'Failed to send reset email. Please try again.',
        isError: true,
      );
      return false;
    }
  }

  /// Handle specific Supabase AuthException errors
  void _handleAuthException(AuthException e) {
    String title = 'Authentication Error';
    String message = e.message;

    // Check for specific error codes and messages
    if (e.statusCode == '400') {
      if (e.message.toLowerCase().contains('email not confirmed') ||
          e.message.toLowerCase().contains('email_not_confirmed')) {
        title = 'Email Not Verified';
        message =
            'Please check your email and click the verification link to activate your account.';
      } else if (e.message.toLowerCase().contains(
        'invalid login credentials',
      )) {
        title = 'Invalid Credentials';
        message = 'The email or password you entered is incorrect.';
      } else if (e.message.toLowerCase().contains('user already registered')) {
        title = 'Account Exists';
        message =
            'An account with this email already exists. Please login instead.';
      }
    } else if (e.statusCode == '422') {
      title = 'Invalid Email';
      message = 'Please enter a valid email address.';
    } else if (e.statusCode == '429') {
      title = 'Too Many Attempts';
      message = 'Too many requests. Please try again later.';
    }

    Helpers.showSnackbar(title, message, isError: true);
  }
}
