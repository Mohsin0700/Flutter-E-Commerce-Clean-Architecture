class UserModel {
  final String id;
  final String email;
  final String name;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.isAdmin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      isAdmin: json['isAdmin'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name, 'isAdmin': isAdmin};
  }
}
