import 'package:imr/data/models/address_model.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? avatar;
  final bool isAdmin;
  final List<AddressModel> addresses;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.avatar,
    required this.isAdmin,
    this.addresses = const [],
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      avatar: json['avatar'],
      isAdmin: json['isAdmin'] ?? false,
      addresses:
          (json['addresses'] as List?)
              ?.map((a) => AddressModel.fromJson(a))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'avatar': avatar,
      'isAdmin': isAdmin,
      'addresses': addresses.map((a) => a.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
