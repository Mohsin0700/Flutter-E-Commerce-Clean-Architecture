import 'package:get/get.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/order_model.dart';
import 'package:imr/data/models/product_model.dart';
import 'package:imr/data/repositories/order_repository.dart';
import 'package:imr/data/repositories/product_repository.dart';

class AdminController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();
  final OrderRepository _orderRepository = OrderRepository();

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final RxBool isLoading = false.obs;

  // Analytics data
  final RxDouble totalRevenue = 0.0.obs;
  final RxInt totalOrders = 0.obs;
  final RxInt totalProducts = 0.obs;
  final RxInt totalUsers = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.wait([fetchProducts(), fetchOrders(), fetchAnalytics()]);
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      products.value = await _productRepository.getProducts();
      totalProducts.value = products.length;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrders() async {
    try {
      orders.value = await _orderRepository.getAllOrders();
      totalOrders.value = orders.length;
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  Future<void> fetchAnalytics() async {
    // Calculate analytics
    totalRevenue.value = orders.fold(
      0,
      (sum, order) => sum + order.totalAmount,
    );
    totalUsers.value = 150; // Mock data
  }

  Future<void> addProduct(ProductModel product) async {
    isLoading.value = true;
    try {
      await _productRepository.addProduct(product);
      await fetchProducts();
      Helpers.showSnackbar('Success', 'Product added successfully');
    } catch (e) {
      Helpers.showSnackbar('Error', 'Failed to add product', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    isLoading.value = true;
    try {
      await _productRepository.updateProduct(product);
      await fetchProducts();
      Helpers.showSnackbar('Success', 'Product updated successfully');
    } catch (e) {
      Helpers.showSnackbar('Error', 'Failed to update product', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(String id) async {
    isLoading.value = true;
    try {
      await _productRepository.deleteProduct(id);
      await fetchProducts();
      Helpers.showSnackbar('Success', 'Product deleted successfully');
    } catch (e) {
      Helpers.showSnackbar('Error', 'Failed to delete product', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _orderRepository.updateOrderStatus(orderId, status);
      await fetchOrders();
      Helpers.showSnackbar('Success', 'Order status updated');
    } catch (e) {
      Helpers.showSnackbar('Error', 'Failed to update status', isError: true);
    }
  }
}
