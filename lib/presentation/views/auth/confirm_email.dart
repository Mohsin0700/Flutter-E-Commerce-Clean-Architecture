import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/core/utils/validators.dart';
import 'package:imr/presentation/controllers/auth_controller.dart';
import 'package:imr/presentation/views/auth/login_view.dart';

class ConfirmEmail extends GetView<AuthController> {
  final otpTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ConfirmEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Email Verification')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'OTP Verification',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Check your email for a verification code',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 32),
                TextFormField(
                  controller: otpTextController,
                  decoration: InputDecoration(
                    labelText: 'Enter OTP here!',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) => Validators.required(value, 'Name'),
                ),
                SizedBox(height: 16),

                Obx(
                  () => controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {}
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 56),
                          ),
                          child: Text(
                            'Confirm',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? '),
                    TextButton(
                      onPressed: () => Get.off(() => LoginView()),
                      child: Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
