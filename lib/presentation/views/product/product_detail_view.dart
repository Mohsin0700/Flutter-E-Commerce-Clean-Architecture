import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/data/models/product_model.dart';
import 'package:imr/presentation/controllers/cart_controller.dart';

class ProductDetailView extends StatelessWidget {
  final CartController cartController = Get.find();

  ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey[200],
              child: Center(
                child: Icon(Icons.image, size: 120, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.category, size: 20, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        product.category,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      SizedBox(width: 24),
                      Icon(Icons.inventory, size: 20, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        '${product.stock} in stock',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        cartController.addToCart(product);
                      },
                      icon: Icon(Icons.shopping_cart),
                      label: Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
