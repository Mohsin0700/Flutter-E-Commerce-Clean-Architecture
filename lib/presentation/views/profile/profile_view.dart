import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/core/themes/app_colors.dart';
import 'package:imr/presentation/controllers/auth_controller.dart';
import 'package:imr/presentation/controllers/profile_controller.dart';
import 'package:imr/presentation/widgets/custom_button.dart';

class ProfileView extends GetView<ProfileController> {
  final AuthController authController = Get.find();

  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = authController.currentUser.value;

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            SizedBox(height: 16),
            Text(
              user?.name ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(user?.email ?? '', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 32),
            _buildMenuItem(
              icon: Icons.edit,
              title: 'Edit Profile',
              onTap: () => Get.toNamed(AppRoutes.EDIT_PROFILE),
            ),
            _buildMenuItem(
              icon: Icons.location_on,
              title: 'My Addresses',
              onTap: () => Get.toNamed(AppRoutes.ADDRESS),
            ),
            _buildMenuItem(
              icon: Icons.receipt_long,
              title: 'My Orders',
              onTap: () => Get.toNamed(AppRoutes.ORDERS),
            ),
            _buildMenuItem(
              icon: Icons.favorite,
              title: 'Wishlist',
              onTap: () => Get.toNamed(AppRoutes.WISHLIST),
            ),
            _buildMenuItem(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.help,
              title: 'Help & Support',
              onTap: () {},
            ),
            _buildMenuItem(icon: Icons.info, title: 'About', onTap: () {}),
            SizedBox(height: 16),
            CustomButton(
              text: 'Logout',
              color: Colors.red,
              onPressed: () => authController.logout(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
