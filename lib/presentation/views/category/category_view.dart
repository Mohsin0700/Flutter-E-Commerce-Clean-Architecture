import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/data/models/category_model.dart';
import 'package:imr/presentation/controllers/cart_controller.dart';
import 'package:imr/presentation/controllers/product_controller.dart';
import 'package:imr/presentation/widgets/product_card.dart';

class CategoryView extends StatelessWidget {
  final ProductController productController = Get.find();
  final CartController cartController = Get.find();

  CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryModel category = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (productController.products.isEmpty) {
          return Center(child: Text('No products found'));
        }

        return GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
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
        );
      }),
    );
  }
}
