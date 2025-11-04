import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/data/models/product_model.dart';
import 'package:imr/presentation/controllers/cart_controller.dart';
import 'package:imr/presentation/controllers/product_controller.dart';
import 'package:imr/presentation/controllers/whishlist_controller.dart';
import 'package:imr/presentation/widgets/product_card.dart';

class WishlistView extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final WishlistController wishlistController = Get.find();
  final CartController cartController = Get.find();

  WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wishlist')),
      body: Obx(() {
        if (wishlistController.wishlistIds.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 100, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Your wishlist is empty',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return FutureBuilder<List<ProductModel>>(
          future: productController.productRepository.getProducts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final wishlistProducts = snapshot.data!
                .where((p) => wishlistController.wishlistIds.contains(p.id))
                .toList();

            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: wishlistProducts.length,
              itemBuilder: (context, index) {
                final product = wishlistProducts[index];
                return ProductCard(
                  product: product,
                  onTap: () =>
                      Get.toNamed(AppRoutes.PRODUCT_DETAIL, arguments: product),
                  onAddToCart: () => cartController.addToCart(product),
                );
              },
            );
          },
        );
      }),
    );
  }
}
