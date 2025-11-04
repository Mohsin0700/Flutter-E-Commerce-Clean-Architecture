import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/config/app_config.dart';
import 'package:imr/core/themes/app_colors.dart';

class Helpers {
  static String formatPrice(double price) {
    return '${AppConfig.currency}${price.toStringAsFixed(2)}';
  }

  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static void showSnackbar(
    String title,
    String message, {
    bool isError = false,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: isError ? AppColors.error : AppColors.success,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }

  static double calculateDiscount(
    double originalPrice,
    double discountPercent,
  ) {
    return originalPrice - (originalPrice * discountPercent / 100);
  }
}
