import 'package:imr/data/models/category_model.dart';

class CategoryRepository {
  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(Duration(milliseconds: 500));
    return [
      CategoryModel(
        id: '1',
        name: 'Electronics',
        icon: 'laptop',
        productCount: 150,
      ),
      CategoryModel(id: '2', name: 'Fashion', icon: 'shirt', productCount: 230),
      CategoryModel(
        id: '3',
        name: 'Home & Garden',
        icon: 'home',
        productCount: 180,
      ),
      CategoryModel(
        id: '4',
        name: 'Sports',
        icon: 'basketball',
        productCount: 95,
      ),
      CategoryModel(id: '5', name: 'Books', icon: 'book', productCount: 340),
      CategoryModel(id: '6', name: 'Toys', icon: 'toy', productCount: 120),
      CategoryModel(id: '7', name: 'Beauty', icon: 'spa', productCount: 85),
      CategoryModel(id: '8', name: 'Automotive', icon: 'car', productCount: 67),
    ];
  }
}
