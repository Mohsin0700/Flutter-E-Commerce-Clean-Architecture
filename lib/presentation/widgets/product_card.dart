// lib/presentation/widgets/product_card.dart
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/core/themes/app_colors.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/product_model.dart';
import 'package:imr/presentation/controllers/whishlist_controller.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductCard({
    required this.product,
    required this.onTap,
    required this.onAddToCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.find();

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxH = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 320.0;

        final imageHeight = maxH * 0.36;
        const double defaultButtonHeight = 36.0;
        final contentPadding = 5.0;
        final remainingForContent = maxH - imageHeight - (contentPadding * 2);

        final bool isCompact = remainingForContent < 120;

        final compactTitleLines = 1; // fixed to 1 for ellipsis
        final compactSpacingSmall = isCompact ? 4.0 : 6.0;
        final compactButtonHeight = isCompact ? 30.0 : defaultButtonHeight;
        final safeButtonHeight = math.min(
          compactButtonHeight,
          math.max(24.0, remainingForContent * 0.18),
        );

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image area
                Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          fit: BoxFit.contain,
                          imageUrl: product.imageUrl,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      if (product.hasDiscount)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '-${product.discountPercent.toStringAsFixed(0)}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Obx(
                          () => GestureDetector(
                            onTap: () =>
                                wishlistController.toggleWishlist(product.id),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Icon(
                                wishlistController.isInWishlist(product.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    wishlistController.isInWishlist(product.id)
                                    ? Colors.red
                                    : Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Content area with flexible space
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(contentPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product name limited to 1 line with ellipsis
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: compactSpacingSmall),

                        // Rating row
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${product.rating}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '(${product.reviewCount})',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        if (product.hasDiscount) ...[
                          Text(
                            Helpers.formatPrice(product.originalPrice!),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(height: compactSpacingSmall),
                        ],

                        // Price
                        Text(
                          Helpers.formatPrice(product.price),
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: isCompact ? 14 : 16,
                          ),
                        ),

                        SizedBox(height: compactSpacingSmall),
                      ],
                    ),
                  ),
                ),

                // Fixed "Add" button
                SizedBox(
                  width: double.infinity,
                  height: safeButtonHeight.clamp(28.0, defaultButtonHeight),
                  child: ElevatedButton(
                    onPressed: onAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      minimumSize: Size(0, safeButtonHeight),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: isCompact ? 12 : 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
