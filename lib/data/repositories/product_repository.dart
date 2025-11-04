import 'package:imr/data/models/product_model.dart';

class ProductRepository {
  Future<List<ProductModel>> getProducts({
    String? category,
    String? searchQuery,
  }) async {
    await Future.delayed(Duration(seconds: 1));

    List<ProductModel> products = [
      ProductModel(
        id: '1',
        name: 'iPhone 15 Pro Max',
        description:
            'Latest iPhone with A17 Pro chip, titanium design, and advanced camera system',
        price: 999.99,
        originalPrice: 1199.99,
        imageUrl: 'https://via.placeholder.com/300',
        images: [
          'https://via.placeholder.com/300',
          'https://via.placeholder.com/300',
        ],
        category: 'Electronics',
        stock: 50,
        rating: 4.8,
        reviewCount: 234,
        isFeatured: true,
        isNew: true,
        tags: ['smartphone', 'apple', 'flagship'],
      ),
      ProductModel(
        id: '2',
        name: 'MacBook Pro 16"',
        description: 'Powerful laptop for professionals with M3 Max chip',
        price: 2499.99,
        originalPrice: 2799.99,
        imageUrl: 'https://via.placeholder.com/300',
        images: ['https://via.placeholder.com/300'],
        category: 'Electronics',
        stock: 30,
        rating: 4.9,
        reviewCount: 156,
        isFeatured: true,
        tags: ['laptop', 'apple', 'professional'],
      ),
      ProductModel(
        id: '3',
        name: 'AirPods Pro 2',
        description: 'Premium wireless earbuds with active noise cancellation',
        price: 249.99,
        imageUrl: 'https://via.placeholder.com/300',
        images: ['https://via.placeholder.com/300'],
        category: 'Electronics',
        stock: 100,
        rating: 4.7,
        reviewCount: 567,
        tags: ['audio', 'wireless', 'apple'],
      ),
      ProductModel(
        id: '4',
        name: 'Nike Air Max 270',
        description: 'Comfortable running shoes with Air cushioning technology',
        price: 150.00,
        originalPrice: 180.00,
        imageUrl: 'https://via.placeholder.com/300',
        images: ['https://via.placeholder.com/300'],
        category: 'Fashion',
        stock: 75,
        rating: 4.5,
        reviewCount: 89,
        isNew: true,
        tags: ['shoes', 'sports', 'nike'],
      ),
      ProductModel(
        id: '5',
        name: 'Samsung 4K Smart TV',
        description: '55" QLED 4K Smart TV with HDR and AI upscaling',
        price: 799.99,
        originalPrice: 999.99,
        imageUrl: 'https://via.placeholder.com/300',
        images: ['https://via.placeholder.com/300'],
        category: 'Electronics',
        stock: 25,
        rating: 4.6,
        reviewCount: 123,
        isFeatured: true,
        tags: ['tv', 'samsung', '4k'],
      ),
      ProductModel(
        id: '6',
        name: 'Leather Jacket',
        description: 'Premium genuine leather jacket with modern fit',
        price: 299.99,
        imageUrl: 'https://via.placeholder.com/300',
        images: ['https://via.placeholder.com/300'],
        category: 'Fashion',
        stock: 40,
        rating: 4.4,
        reviewCount: 67,
        tags: ['jacket', 'leather', 'fashion'],
      ),
    ];

    if (category != null && category.isNotEmpty) {
      products = products.where((p) => p.category == category).toList();
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      products = products
          .where(
            (p) =>
                p.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                p.description.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ) ||
                p.tags.any(
                  (tag) =>
                      tag.toLowerCase().contains(searchQuery.toLowerCase()),
                ),
          )
          .toList();
    }

    return products;
  }

  Future<ProductModel> getProductById(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    final products = await getProducts();
    return products.firstWhere((p) => p.id == id);
  }

  Future<List<ProductModel>> getFeaturedProducts() async {
    final products = await getProducts();
    return products.where((p) => p.isFeatured).toList();
  }

  Future<List<ProductModel>> getNewProducts() async {
    final products = await getProducts();
    return products.where((p) => p.isNew).toList();
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
