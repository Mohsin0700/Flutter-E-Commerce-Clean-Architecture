import 'package:get/get.dart';
import 'package:imr/presentation/controllers/admin_controller.dart';
import 'package:imr/presentation/controllers/auth_controller.dart';
import 'package:imr/presentation/controllers/cart_controller.dart';
import 'package:imr/presentation/controllers/category_controller.dart';
import 'package:imr/presentation/controllers/order_controller.dart';
import 'package:imr/presentation/controllers/product_controller.dart';
import 'package:imr/presentation/controllers/profile_controller.dart';
import 'package:imr/presentation/controllers/search_controller.dart';
import 'package:imr/presentation/controllers/whishlist_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.put(WishlistController(), permanent: true);
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => CategoryController());
  }
}

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WishlistController());
  }
}

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminController());
  }
}
