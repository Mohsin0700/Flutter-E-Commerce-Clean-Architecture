class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final int productCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.productCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      productCount: json['productCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon, 'productCount': productCount};
  }
}
