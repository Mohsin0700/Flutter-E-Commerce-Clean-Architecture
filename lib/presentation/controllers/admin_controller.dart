import 'package:get/get.dart';
import 'package:imr/data/models/order_model.dart';
import 'package:imr/data/models/product_model.dart';
import 'package:imr/data/repositories/order_repository.dart';
import 'package:imr/data/repositories/product_repository.dart';
import 'package:imr/presentation/controllers/cart_controller.dart';
import 'package:imr/presentation/controllers/product_controller.dart';

class AdminController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();
  final OrderRepository _orderRepository = OrderRepository();

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchOrders();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      final result = await _productRepository.getProducts();
      products.value = result;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrders() async {
    try {
      final result = await _orderRepository.getAllOrders();
      orders.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch orders');
    }
  }

  Future<void> addProduct(ProductModel product) async {
    isLoading.value = true;
    try {
      await _productRepository.addProduct(product);
      await fetchProducts();
      Get.snackbar('Success', 'Product added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    isLoading.value = true;
    try {
      await _productRepository.updateProduct(product);
      await fetchProducts();
      Get.snackbar('Success', 'Product updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(String id) async {
    isLoading.value = true;
    try {
      await _productRepository.deleteProduct(id);
      await fetchProducts();
      Get.snackbar('Success', 'Product deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete product');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _orderRepository.updateOrderStatus(orderId, status);
      await fetchOrders();
      Get.snackbar('Success', 'Order status updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update order status');
    }
  }
}

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => CartController());
  }
}
