import 'package:get/get.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/address_model.dart';
import 'package:imr/data/models/user_model.dart';
import 'package:imr/presentation/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final AuthController _authController = Get.find();

  final RxList<AddressModel> addresses = <AddressModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAddresses();
  }

  void loadAddresses() {
    addresses.value = _authController.currentUser.value?.addresses ?? [];
  }

  Future<void> updateProfile(String name, String phone) async {
    isLoading.value = true;
    try {
      final user = _authController.currentUser.value;
      if (user != null) {
        final updatedUser = UserModel(
          id: user.id,
          email: user.email,
          name: name,
          phone: phone,
          avatar: user.avatar,
          isAdmin: user.isAdmin,
          addresses: user.addresses,
          createdAt: user.createdAt,
        );
        await _authController.updateProfile(updatedUser);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void addAddress(AddressModel address) {
    addresses.add(address);
    _updateUserAddresses();
    Helpers.showSnackbar('Success', 'Address added successfully');
  }

  void updateAddress(AddressModel address) {
    final index = addresses.indexWhere((a) => a.id == address.id);
    if (index != -1) {
      addresses[index] = address;
      _updateUserAddresses();
      Helpers.showSnackbar('Success', 'Address updated successfully');
    }
  }

  void deleteAddress(String addressId) {
    addresses.removeWhere((a) => a.id == addressId);
    _updateUserAddresses();
    Helpers.showSnackbar('Success', 'Address deleted successfully');
  }

  void _updateUserAddresses() {
    final user = _authController.currentUser.value;
    if (user != null) {
      final updatedUser = UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        phone: user.phone,
        avatar: user.avatar,
        isAdmin: user.isAdmin,
        addresses: addresses.toList(),
        createdAt: user.createdAt,
      );
      _authController.updateProfile(updatedUser);
    }
  }
}
