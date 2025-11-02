import 'package:get/get.dart';
import 'package:imr/data/models/product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;

  double get totalAmount => items.fold(0, (sum, item) => sum + item.totalPrice);
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  void addToCart(ProductModel product) {
    final existingItem = items.firstWhereOrNull(
      (item) => item.product.id == product.id,
    );
    if (existingItem != null) {
      existingItem.quantity++;
      items.refresh();
    } else {
      items.add(CartItem(product: product));
    }
    Get.snackbar('Success', '${product.name} added to cart');
  }

  void removeFromCart(String productId) {
    items.removeWhere((item) => item.product.id == productId);
  }

  void updateQuantity(String productId, int quantity) {
    final item = items.firstWhereOrNull((item) => item.product.id == productId);
    if (item != null) {
      item.quantity = quantity;
      if (item.quantity <= 0) {
        removeFromCart(productId);
      }
      items.refresh();
    }
  }

  void clearCart() {
    items.clear();
  }
}

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}
