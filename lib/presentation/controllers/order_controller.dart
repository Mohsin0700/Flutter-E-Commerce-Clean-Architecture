import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/order_model.dart';
import 'package:imr/data/repositories/order_repository.dart';
import 'package:imr/presentation/controllers/auth_controller.dart';

class OrderController extends GetxController {
  final OrderRepository _orderRepository = OrderRepository();
  final AuthController _authController = Get.find();

  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<OrderModel?> selectedOrder = Rx<OrderModel?>(null);

  @override
  void onInit() {
    super.onInit();
    if (_authController.isLoggedIn) {
      fetchUserOrders();
    }
  }

  Future<void> fetchUserOrders() async {
    isLoading.value = true;
    try {
      final userId = _authController.currentUser.value?.id ?? '';
      orders.value = await _orderRepository.getUserOrders(userId);
    } catch (e) {
      Helpers.showSnackbar('Error', 'Failed to fetch orders', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrder(OrderModel order) async {
    isLoading.value = true;
    try {
      await _orderRepository.createOrder(order);
      Helpers.showSnackbar('Success', 'Order placed successfully!');
      Get.offAllNamed(AppRoutes.ORDERS);
    } catch (e) {
      Helpers.showSnackbar('Error', 'Failed to create order', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrderById(String orderId) async {
    isLoading.value = true;
    try {
      selectedOrder.value = await _orderRepository.getOrderById(orderId);
    } finally {
      isLoading.value = false;
    }
  }
}
