import 'package:get/get.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/product_model.dart';
import 'package:imr/data/repositories/product_repository.dart';

class SearchController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();

  final RxList<ProductModel> searchResults = <ProductModel>[].obs;
  final RxList<String> recentSearches = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  Future<void> search(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    searchQuery.value = query;
    isLoading.value = true;

    try {
      final results = await _productRepository.getProducts(searchQuery: query);
      searchResults.value = results;
      _addToRecentSearches(query);
    } catch (e) {
      Helpers.showSnackbar('Error', 'Search failed', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  void _addToRecentSearches(String query) {
    recentSearches.remove(query);
    recentSearches.insert(0, query);
    if (recentSearches.length > 10) {
      recentSearches.removeLast();
    }
  }

  void clearRecentSearches() {
    recentSearches.clear();
  }
}
