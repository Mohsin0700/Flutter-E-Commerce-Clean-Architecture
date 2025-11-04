import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/core/constants/app_constants.dart';
import 'package:imr/core/themes/app_colors.dart';
import 'package:imr/presentation/controllers/auth_controller.dart';
import 'package:imr/presentation/controllers/cart_controller.dart';
import 'package:imr/presentation/controllers/category_controller.dart';
import 'package:imr/presentation/controllers/product_controller.dart';
import 'package:imr/presentation/controllers/whishlist_controller.dart';
import 'package:imr/presentation/widgets/product_card.dart';

class HomeView extends StatelessWidget {
  final ProductController productController = Get.find();
  final CategoryController categoryController = Get.find();
  final CartController cartController = Get.find();
  final WishlistController wishlistController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce Pro'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Get.toNamed(AppRoutes.SEARCH),
          ),
          Obx(
            () => Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () => Get.toNamed(AppRoutes.WISHLIST),
                ),
                if (wishlistController.wishlistIds.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${wishlistController.wishlistIds.length}',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Obx(
            () => Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () => Get.toNamed(AppRoutes.CART),
                ),
                if (cartController.itemCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cartController.itemCount}',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: RefreshIndicator(
        onRefresh: () async {
          await productController.fetchProducts();
          await categoryController.fetchCategories();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(),
              _buildCategories(),
              _buildFeaturedProducts(),
              _buildNewProducts(),
              _buildAllProducts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: AppColors.primary),
                ),
                SizedBox(height: 8),
                Obx(
                  () => Text(
                    authController.currentUser.value?.name ?? 'Guest',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    authController.currentUser.value?.email ?? '',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Get.back(),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.PROFILE);
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text('My Orders'),
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.ORDERS);
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Wishlist'),
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.WISHLIST);
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Addresses'),
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.ADDRESS);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Get.back(),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help & Support'),
            onTap: () => Get.back(),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () => authController.logout(),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 200,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Special Offer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Get up to 50% off on selected items',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text('Shop Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Obx(
          () => SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: categoryController.categories.length,
              itemBuilder: (context, index) {
                final category = categoryController.categories[index];
                return GestureDetector(
                  onTap: () {
                    productController.filterByCategory(category.name);
                    Get.toNamed(AppRoutes.CATEGORY, arguments: category);
                  },
                  child: Container(
                    width: 80,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.category, color: AppColors.primary),
                        ),
                        SizedBox(height: 8),
                        Text(
                          category.name,
                          style: TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProducts() {
    return Obx(() {
      if (productController.featuredProducts.isEmpty) return SizedBox();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: Text('See All')),
              ],
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: productController.featuredProducts.length,
              itemBuilder: (context, index) {
                final product = productController.featuredProducts[index];
                return Container(
                  width: 180,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: ProductCard(
                    product: product,
                    onTap: () => Get.toNamed(
                      AppRoutes.PRODUCT_DETAIL,
                      arguments: product,
                    ),
                    onAddToCart: () => cartController.addToCart(product),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildNewProducts() {
    return Obx(() {
      if (productController.newProducts.isEmpty) return SizedBox();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Arrivals',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: Text('See All')),
              ],
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: productController.newProducts.length,
              itemBuilder: (context, index) {
                final product = productController.newProducts[index];
                return Container(
                  width: 180,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: ProductCard(
                    product: product,
                    onTap: () => Get.toNamed(
                      AppRoutes.PRODUCT_DETAIL,
                      arguments: product,
                    ),
                    onAddToCart: () => cartController.addToCart(product),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildAllProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Obx(
                () => DropdownButton<String>(
                  value: productController.sortBy.value,
                  items: AppConstants.sortOptions
                      .map(
                        (sort) => DropdownMenuItem(
                          value: sort,
                          child: Text(sort, style: TextStyle(fontSize: 14)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) productController.setSortBy(value);
                  },
                  underline: SizedBox(),
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          if (productController.isLoading.value) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
      ],
    );
  }
}
