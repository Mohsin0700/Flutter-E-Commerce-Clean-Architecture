import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/address_model.dart';
import 'package:imr/data/models/order_model.dart';
import 'package:imr/presentation/controllers/auth_controller.dart';
import 'package:imr/presentation/controllers/cart_controller.dart';
import 'package:imr/presentation/controllers/order_controller.dart';
import 'package:imr/presentation/widgets/custom_button.dart';

class CheckoutView extends StatelessWidget {
  final CartController cartController = Get.find();
  final OrderController orderController = Get.find();
  final AuthController authController = Get.find();

  CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...cartController.items.map(
              (item) => ListTile(
                title: Text(item.product.name),
                subtitle: Text('Quantity: ${item.quantity}'),
                trailing: Text(Helpers.formatPrice(item.totalPrice)),
              ),
            ),
            Divider(height: 32),
            Text(
              'Payment Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              title: Text('Credit Card'),
              value: 'credit_card',
              groupValue: 'credit_card',
              onChanged: (value) {},
            ),
            RadioListTile(
              title: Text('Cash on Delivery'),
              value: 'cod',
              groupValue: 'credit_card',
              onChanged: (value) {},
            ),
            SizedBox(height: 32),
            CustomButton(
              text:
                  'Place Order - ${Helpers.formatPrice(cartController.totalAmount)}',
              onPressed: () {
                final order = OrderModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  userId: authController.currentUser.value?.id ?? '',
                  items: cartController.items
                      .map(
                        (item) => OrderItem(
                          productId: item.product.id,
                          productName: item.product.name,
                          productImage: item.product.imageUrl,
                          quantity: item.quantity,
                          price: item.product.price,
                        ),
                      )
                      .toList(),
                  subtotal: cartController.subtotal,
                  shipping: cartController.shipping,
                  tax: cartController.tax,
                  totalAmount: cartController.totalAmount,
                  status: 'Pending',
                  shippingAddress: AddressModel(
                    id: '1',
                    fullName: 'John Doe',
                    phone: '+1234567890',
                    street: '123 Main St',
                    city: 'New York',
                    state: 'NY',
                    zipCode: '10001',
                    country: 'USA',
                  ),
                  paymentMethod: 'Credit Card',
                  createdAt: DateTime.now(),
                );
                orderController.createOrder(order);
                cartController.clearCart();
              },
            ),
          ],
        ),
      ),
    );
  }
}
