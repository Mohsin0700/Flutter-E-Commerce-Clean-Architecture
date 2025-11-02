import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/presentation/controllers/admin_controller.dart';
import 'package:imr/presentation/controllers/auth_controller.dart';

class AdminDashboardView extends GetView<AdminController> {
  final AuthController authController = Get.find();

  AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Admin',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  DashboardCard(
                    title: 'Manage Products',
                    icon: Icons.inventory,
                    color: Colors.blue,
                    onTap: () => Get.toNamed(AppRoutes.ADMIN_PRODUCTS),
                  ),
                  DashboardCard(
                    title: 'Manage Orders',
                    icon: Icons.receipt_long,
                    color: Colors.green,
                    onTap: () => Get.toNamed(AppRoutes.ADMIN_ORDERS),
                  ),
                  Obx(
                    () => DashboardCard(
                      title: 'Total Products',
                      icon: Icons.shopping_bag,
                      color: Colors.orange,
                      subtitle: '${controller.products.length}',
                      onTap: () {},
                    ),
                  ),
                  Obx(
                    () => DashboardCard(
                      title: 'Total Orders',
                      icon: Icons.local_shipping,
                      color: Colors.purple,
                      subtitle: '${controller.orders.length}',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String? subtitle;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 8),
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
