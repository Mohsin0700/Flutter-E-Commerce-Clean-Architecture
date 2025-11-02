import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/data/models/product_model.dart';
import 'package:imr/presentation/controllers/admin_controller.dart';

class ManageProductsView extends GetView<AdminController> {
  const ManageProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Products')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.image, color: Colors.grey),
                ),
                title: Text(product.name),
                subtitle: Text('\${product.price.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showProductDialog(context, product),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _confirmDelete(context, product.id),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProductDialog(context, null),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showProductDialog(BuildContext context, ProductModel? product) {
    final nameController = TextEditingController(text: product?.name ?? '');
    final descController = TextEditingController(
      text: product?.description ?? '',
    );
    final priceController = TextEditingController(
      text: product?.price.toString() ?? '',
    );
    final categoryController = TextEditingController(
      text: product?.category ?? '',
    );
    final stockController = TextEditingController(
      text: product?.stock.toString() ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product == null ? 'Add Product' : 'Edit Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: stockController,
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final newProduct = ProductModel(
                id:
                    product?.id ??
                    DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameController.text,
                description: descController.text,
                price: double.tryParse(priceController.text) ?? 0,
                imageUrl: 'https://via.placeholder.com/300',
                category: categoryController.text,
                stock: int.tryParse(stockController.text) ?? 0,
              );

              if (product == null) {
                controller.addProduct(newProduct);
              } else {
                controller.updateProduct(newProduct);
              }
              Get.back();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              controller.deleteProduct(id);
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
