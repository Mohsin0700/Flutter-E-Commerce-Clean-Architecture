import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/presentation/controllers/auth_controller.dart';
import 'package:imr/presentation/controllers/cart_controller.dart';
import 'package:imr/presentation/controllers/product_controller.dart';
import 'package:imr/presentation/widgets/product_card.dart';

class HomeView extends StatelessWidget {
  final ProductController productController = Get.find();
  final CartController cartController = Get.find();
  final AuthController authController = Get.put(AuthController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce'),
        actions: [
          Obx(
            () => IconButton(
              icon: Badge(
                label: Text('${cartController.itemCount}'),
                child: Icon(Icons.shopping_cart),
              ),
              onPressed: () => Get.toNamed(AppRoutes.CART),
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () => productController.fetchProducts(),
          child: GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              final product = productController.products[index];
              return ProductCard(
                product: product,
                onTap: () =>
                    Get.toNamed(AppRoutes.PRODUCT_DETAIL, arguments: product),
                onAddToCart: () => cartController.addToCart(product),
              );
            },
          ),
        );
      }),
    );
  }
}
