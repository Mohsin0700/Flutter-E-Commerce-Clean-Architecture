import 'package:imr/data/models/product_model.dart';

class ProductRepository {
  // Mock data - replace with actual API calls
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      ProductModel(
        id: '1',
        name: 'iPhone 15 Pro',
        description: 'Latest iPhone with A17 Pro chip',
        price: 999.99,
        imageUrl: 'https://via.placeholder.com/300',
        category: 'Electronics',
        stock: 50,
      ),
      ProductModel(
        id: '2',
        name: 'MacBook Pro',
        description: 'Powerful laptop for professionals',
        price: 2499.99,
        imageUrl: 'https://via.placeholder.com/300',
        category: 'Electronics',
        stock: 30,
      ),
      ProductModel(
        id: '3',
        name: 'AirPods Pro',
        description: 'Premium wireless earbuds',
        price: 249.99,
        imageUrl: 'https://via.placeholder.com/300',
        category: 'Electronics',
        stock: 100,
      ),
    ];
  }

  Future<ProductModel> getProductById(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    final products = await getProducts();
    return products.firstWhere((p) => p.id == id);
  }

  Future<bool> addProduct(ProductModel product) async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  Future<bool> updateProduct(ProductModel product) async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  Future<bool> deleteProduct(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }
}
