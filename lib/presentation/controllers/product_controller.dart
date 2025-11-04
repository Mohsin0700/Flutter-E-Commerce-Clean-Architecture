import 'package:get/get.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/product_model.dart';
import 'package:imr/data/repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final RxList<ProductModel> newProducts = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<ProductModel?> selectedProduct = Rx<ProductModel?>(null);
  final RxString selectedCategory = ''.obs;
  final RxString sortBy = 'Featured'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchFeaturedProducts();
    fetchNewProducts();
  }

  Future<void> fetchProducts({String? category, String? search}) async {
    isLoading.value = true;
    try {
      final result = await _productRepository.getProducts(
        category: category,
        searchQuery: search,
      );
      products.value = _sortProducts(result);
    } catch (e) {
      Helpers.showSnackbar('Error', 'Failed to fetch products', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      featuredProducts.value = await _productRepository.getFeaturedProducts();
    } catch (e) {
      print('Error fetching featured products: $e');
    }
  }

  Future<void> fetchNewProducts() async {
    try {
      newProducts.value = await _productRepository.getNewProducts();
    } catch (e) {
      print('Error fetching new products: $e');
    }
  }

  Future<void> fetchProductById(String id) async {
    isLoading.value = true;
    try {
      selectedProduct.value = await _productRepository.getProductById(id);
    } catch (e) {
      Helpers.showSnackbar('Error', 'Failed to fetch product', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    fetchProducts(category: category);
  }

  void setSortBy(String sort) {
    sortBy.value = sort;
    products.value = _sortProducts(products);
  }

  List<ProductModel> _sortProducts(List<ProductModel> products) {
    List<ProductModel> sorted = List.from(products);

    switch (sortBy.value) {
      case 'Price: Low to High':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Newest':
        sorted.sort((a, b) => b.isNew ? 1 : -1);
        break;
      case 'Best Rating':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        sorted.sort((a, b) => b.isFeatured ? 1 : -1);
    }

    return sorted;
  }
}
