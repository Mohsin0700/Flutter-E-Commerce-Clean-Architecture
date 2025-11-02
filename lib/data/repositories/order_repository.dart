import 'package:imr/data/models/order_model.dart';

class OrderRepository {
  Future<List<OrderModel>> getOrders(String userId) async {
    await Future.delayed(Duration(seconds: 1));
    return [];
  }

  Future<List<OrderModel>> getAllOrders() async {
    await Future.delayed(Duration(seconds: 1));
    return [];
  }

  Future<OrderModel> createOrder(OrderModel order) async {
    await Future.delayed(Duration(milliseconds: 500));
    return order;
  }

  Future<bool> updateOrderStatus(String orderId, String status) async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }
}
