import 'menu_item_model.dart';
import 'table_model.dart';

class RestaurantModel {
  final String id;
  final String name;
  final String description;
  final String address;
  final String phone;
  final String email;
  final String ownerId;
  final List<String> images;
  final Map<String, dynamic> openingHours;
  final List<MenuItemModel> menuItems;
  final List<TableModel> tables;
  final double rating;
  final int reviewCount;
  final bool isVip;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.email,
    required this.ownerId,
    this.images = const [],
    this.openingHours = const {},
    this.menuItems = const [],
    this.tables = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isVip = false,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      ownerId: map['ownerId'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      openingHours: Map<String, dynamic>.from(map['openingHours'] ?? {}),
      menuItems: (map['menuItems'] as List? ?? [])
          .map((e) => MenuItemModel.fromMap(e))
          .toList(),
      tables: (map['tables'] as List? ?? [])
          .map((e) => TableModel.fromMap(e))
          .toList(),
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      isVip: map['isVip'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] ?? 0),
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'phone': phone,
      'email': email,
      'ownerId': ownerId,
      'images': images,
      'openingHours': openingHours,
      'menuItems': menuItems.map((e) => e.toMap()).toList(),
      'tables': tables.map((e) => e.toMap()).toList(),
      'rating': rating,
      'reviewCount': reviewCount,
      'isVip': isVip,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'isActive': isActive,
    };
  }
}
