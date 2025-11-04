import 'package:get/get.dart';
import 'package:imr/app/config/app_config.dart';
import 'package:imr/core/constants/app_constants.dart';
import 'package:imr/core/services/storage_service.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

class CartController extends GetxController {
  final StorageService _storageService = Get.find();
  final RxList<CartItem> items = <CartItem>[].obs;

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get shipping =>
      subtotal >= AppConfig.freeShippingThreshold ? 0 : AppConfig.shippingCost;
  double get tax => subtotal * 0.1; // 10% tax
  double get totalAmount => subtotal + shipping + tax;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  @override
  void onInit() {
    super.onInit();
    _loadCartFromStorage();
  }

  void _loadCartFromStorage() {
    final cartData = _storageService.read(AppConstants.CART_KEY);
    if (cartData != null) {
      // Load cart items from storage
    }
  }

  void _saveCartToStorage() {
    _storageService.write(
      AppConstants.CART_KEY,
      items.map((e) => e.product.toJson()).toList(),
    );
  }

  void addToCart(ProductModel product) {
    final existingItem = items.firstWhereOrNull(
      (item) => item.product.id == product.id,
    );
    if (existingItem != null) {
      if (existingItem.quantity < product.stock) {
        existingItem.quantity++;
        items.refresh();
      } else {
        Helpers.showSnackbar('Error', 'Maximum stock reached', isError: true);
        return;
      }
    } else {
      items.add(CartItem(product: product));
    }
    _saveCartToStorage();
    Helpers.showSnackbar('Success', '${product.name} added to cart');
  }

  void removeFromCart(String productId) {
    items.removeWhere((item) => item.product.id == productId);
    _saveCartToStorage();
    Helpers.showSnackbar('Success', 'Item removed from cart');
  }

  void updateQuantity(String productId, int quantity) {
    final item = items.firstWhereOrNull((item) => item.product.id == productId);
    if (item != null) {
      if (quantity <= 0) {
        removeFromCart(productId);
      } else if (quantity <= item.product.stock) {
        item.quantity = quantity;
        items.refresh();
        _saveCartToStorage();
      } else {
        Helpers.showSnackbar('Error', 'Maximum stock reached', isError: true);
      }
    }
  }

  void clearCart() {
    items.clear();
    _saveCartToStorage();
  }
}
