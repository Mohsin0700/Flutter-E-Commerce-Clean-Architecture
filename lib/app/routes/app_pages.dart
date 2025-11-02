import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/presentation/controllers/admin_controller.dart';
import 'package:imr/presentation/controllers/auth_controller.dart';
import 'package:imr/presentation/controllers/cart_controller.dart';
import 'package:imr/presentation/views/admin/admin_dashboard_view.dart';
import 'package:imr/presentation/views/admin/manage_order_view.dart';
import 'package:imr/presentation/views/admin/manage_products_view.dart';
import 'package:imr/presentation/views/cart/cart_view.dart';
import 'package:imr/presentation/views/home_view.dart';
import 'package:imr/presentation/views/login_view.dart';
import 'package:imr/presentation/views/product/product_detail_view.dart';
import 'package:imr/presentation/views/register_view.dart';

import '../../presentation/views/splash_view.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.SPLASH, page: () => SplashView()),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(name: AppRoutes.PRODUCT_DETAIL, page: () => ProductDetailView()),
    GetPage(
      name: AppRoutes.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.ADMIN_DASHBOARD,
      page: () => AdminDashboardView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: AppRoutes.ADMIN_PRODUCTS,
      page: () => ManageProductsView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: AppRoutes.ADMIN_ORDERS,
      page: () => ManageOrdersView(),
      binding: AdminBinding(),
    ),
  ];
}
