import 'package:get/get.dart';
import 'package:imr/core/constants/app_constants.dart';
import 'package:imr/core/services/storage_service.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/repositories/whishlist_repository.dart';

class WishlistController extends GetxController {
  final WishlistRepository _wishlistRepository = WishlistRepository();
  final StorageService _storageService = Get.find();

  final RxList<String> wishlistIds = <String>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadWishlistFromStorage();
  }

  void _loadWishlistFromStorage() {
    final wishlistData = _storageService.read(AppConstants.WISHLIST_KEY);
    if (wishlistData != null) {
      wishlistIds.value = List<String>.from(wishlistData);
    }
  }

  void _saveWishlistToStorage() {
    _storageService.write(AppConstants.WISHLIST_KEY, wishlistIds.toList());
  }

  bool isInWishlist(String productId) {
    return wishlistIds.contains(productId);
  }

  Future<void> toggleWishlist(String productId) async {
    if (isInWishlist(productId)) {
      wishlistIds.remove(productId);
      Helpers.showSnackbar('Success', 'Removed from wishlist');
    } else {
      wishlistIds.add(productId);
      Helpers.showSnackbar('Success', 'Added to wishlist');
    }
    _saveWishlistToStorage();
  }

  Future<void> fetchWishlist(String userId) async {
    isLoading.value = true;
    try {
      wishlistIds.value = await _wishlistRepository.getWishlist(userId);
    } finally {
      isLoading.value = false;
    }
  }
}
