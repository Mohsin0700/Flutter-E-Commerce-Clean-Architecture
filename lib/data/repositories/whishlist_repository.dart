class WishlistRepository {
  Future<List<String>> getWishlist(String userId) async {
    await Future.delayed(Duration(milliseconds: 500));
    return [];
  }

  Future<bool> addToWishlist(String userId, String productId) async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  Future<bool> removeFromWishlist(String userId, String productId) async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }
}
