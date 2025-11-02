import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/routes/app_pages.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/core/themes/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Commerce App',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
