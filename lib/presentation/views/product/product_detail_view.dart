import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/core/themes/app_colors.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/product_model.dart';
import 'package:imr/presentation/controllers/cart_controller.dart';
import 'package:imr/presentation/controllers/whishlist_controller.dart';

class ProductDetailView extends StatelessWidget {
  final CartController cartController = Get.find();
  final WishlistController wishlistController = Get.find();

  ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.grey[200],
                child: Center(
                  child: Icon(Icons.image, size: 120, color: Colors.grey),
                ),
              ),
            ),
            actions: [
              Obx(
                () => IconButton(
                  icon: Icon(
                    wishlistController.isInWishlist(product.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: wishlistController.isInWishlist(product.id)
                        ? Colors.red
                        : null,
                  ),
                  onPressed: () =>
                      wishlistController.toggleWishlist(product.id),
                ),
              ),
              IconButton(icon: Icon(Icons.share), onPressed: () {}),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (product.isNew)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'NEW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (product.hasDiscount) ...[
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'SALE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < product.rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${product.rating}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(${product.reviewCount} reviews)',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      if (product.hasDiscount) ...[
                        Text(
                          Helpers.formatPrice(product.originalPrice!),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: 12),
                      ],
                      Text(
                        Helpers.formatPrice(product.price),
                        style: TextStyle(
                          fontSize: 32,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.category, size: 20, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        product.category,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      SizedBox(width: 24),
                      Icon(Icons.inventory, size: 20, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        '${product.stock} in stock',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  if (product.tags.isNotEmpty) ...[
                    SizedBox(height: 24),
                    Text(
                      'Tags',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.tags
                          .map(
                            (tag) => Chip(
                              label: Text(tag),
                              backgroundColor: AppColors.primary.withOpacity(
                                0.1,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(
                      AppRoutes.PRODUCT_REVIEWS,
                      arguments: product,
                    ),
                    child: Text('Read Reviews (${product.reviewCount})'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48),
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => cartController.addToCart(product),
                icon: Icon(Icons.shopping_cart),
                label: Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  cartController.addToCart(product);
                  Get.toNamed(AppRoutes.CART);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.secondary,
                ),
                child: Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
