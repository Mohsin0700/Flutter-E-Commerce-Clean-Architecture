import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/bindings/initial_bindings.dart';
import 'package:imr/app/routes/app_pages.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/core/services/storage_service.dart';
import 'package:imr/core/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(MyApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => StorageService().init());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Commerce Pro',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
