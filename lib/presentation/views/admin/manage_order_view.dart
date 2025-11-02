import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin_controller.dart';

class ManageOrdersView extends GetView<AdminController> {
  const ManageOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Orders')),
      body: Obx(() {
        if (controller.orders.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long, size: 100, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No orders yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            final order = controller.orders[index];
            return Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ExpansionTile(
                title: Text('Order #${order.id}'),
                subtitle: Text(
                  '\${order.totalAmount.toStringAsFixed(2)} - ${order.status}',
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Items:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        ...order.items.map(
                          (item) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${item.productName} x${item.quantity}'),
                                Text(
                                  '\${(item.price * item.quantity).toStringAsFixed(2)}',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Status:'),
                            DropdownButton<String>(
                              value: order.status,
                              items:
                                  [
                                        'Pending',
                                        'Processing',
                                        'Shipped',
                                        'Delivered',
                                      ]
                                      .map(
                                        (status) => DropdownMenuItem(
                                          value: status,
                                          child: Text(status),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.updateOrderStatus(order.id, value);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
