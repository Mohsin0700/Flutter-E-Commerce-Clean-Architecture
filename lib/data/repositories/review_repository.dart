import 'package:imr/data/models/review_model.dart';

class ReviewRepository {
  Future<List<ReviewModel>> getProductReviews(String productId) async {
    await Future.delayed(Duration(milliseconds: 500));
    return [
      ReviewModel(
        id: '1',
        productId: productId,
        userId: '1',
        userName: 'John Doe',
        rating: 5.0,
        comment: 'Excellent product! Highly recommended.',
        createdAt: DateTime.now().subtract(Duration(days: 5)),
      ),
      ReviewModel(
        id: '2',
        productId: productId,
        userId: '2',
        userName: 'Jane Smith',
        rating: 4.0,
        comment: 'Good quality but a bit expensive.',
        createdAt: DateTime.now().subtract(Duration(days: 10)),
      ),
    ];
  }

  Future<bool> addReview(ReviewModel review) async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }
}
