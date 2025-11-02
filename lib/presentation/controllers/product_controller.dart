import 'package:get/get.dart';
import 'package:imr/data/models/product_model.dart';
import 'package:imr/data/repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<ProductModel?> selectedProduct = Rx<ProductModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      final result = await _productRepository.getProducts();
      products.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductById(String id) async {
    isLoading.value = true;
    try {
      final product = await _productRepository.getProductById(id);
      selectedProduct.value = product;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch product details');
    } finally {
      isLoading.value = false;
    }
  }
}
