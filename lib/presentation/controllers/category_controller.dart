import 'package:get/get.dart';
import 'package:imr/core/utils/helpers.dart';
import 'package:imr/data/models/category_model.dart';
import 'package:imr/data/repositories/category_repository.dart';

class CategoryController extends GetxController {
  final CategoryRepository _categoryRepository = CategoryRepository();

  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      categories.value = await _categoryRepository.getCategories();
    } catch (e) {
      Helpers.showSnackbar(
        'Error',
        'Failed to fetch categories',
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
