import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/core/themes/app_colors.dart';
import 'package:imr/presentation/controllers/auth_controller.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      final AuthController authController = Get.find();
      if (authController.isLoggedIn) {
        if (authController.isAdmin) {
          Get.offAllNamed(AppRoutes.ADMIN_DASHBOARD);
        } else {
          Get.offAllNamed(AppRoutes.HOME);
        }
      } else {
        Get.offAllNamed(AppRoutes.LOGIN);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 120, color: Colors.white),
            SizedBox(height: 24),
            Text(
              'E-Commerce Pro',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
