import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/presentation/controllers/auth_controller.dart';
import 'package:imr/presentation/controllers/profile_controller.dart';
import 'package:imr/presentation/widgets/custom_button.dart';
import 'package:imr/presentation/widgets/custom_textfield.dart';

class EditProfileView extends GetView<ProfileController> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final user = authController.currentUser.value;

    nameController.text = user?.name ?? '';
    phoneController.text = user?.phone ?? '';

    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              controller: nameController,
              label: 'Name',
              prefixIcon: Icons.person,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: phoneController,
              label: 'Phone',
              prefixIcon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 24),
            Obx(
              () => CustomButton(
                text: 'Save Changes',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.updateProfile(
                    nameController.text,
                    phoneController.text,
                  );
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
