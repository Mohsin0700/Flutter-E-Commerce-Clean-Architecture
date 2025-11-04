import 'package:get/get.dart';
import 'package:imr/app/bindings/initial_bindings.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/presentation/views/admin/admin_dashboard_view.dart';
import 'package:imr/presentation/views/admin/manage_order_view.dart';
import 'package:imr/presentation/views/admin/manage_products_view.dart';
import 'package:imr/presentation/views/cart/cart_view.dart';
import 'package:imr/presentation/views/home_view.dart';
import 'package:imr/presentation/views/login_view.dart';
import 'package:imr/presentation/views/product/product_detail_view.dart';
import 'package:imr/presentation/views/register_view.dart';
import 'package:imr/presentation/views/splash_view.dart';

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
      name: AppRoutes.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(name: AppRoutes.PRODUCT_DETAIL, page: () => ProductDetailView()),
    GetPage(name: AppRoutes.PRODUCT_REVIEWS, page: () => ProductReviewsView()),
    GetPage(name: AppRoutes.CATEGORY, page: () => CategoryView()),
    GetPage(
      name: AppRoutes.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(name: AppRoutes.CHECKOUT, page: () => CheckoutView()),
    GetPage(
      name: AppRoutes.WISHLIST,
      page: () => WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: AppRoutes.ORDERS,
      page: () => OrdersView(),
      binding: OrderBinding(),
    ),
    GetPage(name: AppRoutes.ORDER_DETAIL, page: () => OrderDetailView()),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(name: AppRoutes.EDIT_PROFILE, page: () => EditProfileView()),
    GetPage(name: AppRoutes.ADDRESS, page: () => AddressView()),
    GetPage(
      name: AppRoutes.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
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
    GetPage(
      name: AppRoutes.ADMIN_USERS,
      page: () => ManageUsersView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: AppRoutes.ADMIN_ANALYTICS,
      page: () => AnalyticsView(),
      binding: AdminBinding(),
    ),
  ];
}
