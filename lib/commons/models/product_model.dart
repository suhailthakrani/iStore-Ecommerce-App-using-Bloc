import 'package:equatable/equatable.dart';

class Product extends Equatable {
  int id = -1;
  String name = "";
  String image = "";
  String price = "";
  String reviews = "";
  String brand = "";
  String description = "";
  String color = "";
  String storage = "";
  String displaySize = "";
  String processor = "";
  String operatingSystem = "";
  String batteryLife = "";
  String waterResistance = "";
  String connectivity = "";
  String rating = "";
  int quantity = 1;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.reviews,
    required this.brand,
    required this.description,
    required this.color,
    required this.storage,
    required this.displaySize,
    required this.processor,
    required this.operatingSystem,
    required this.batteryLife,
    required this.waterResistance,
    required this.connectivity,
    required this.rating,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? -1,
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      price: json['price'] ?? "",
      reviews: json['reviews'] ?? "",
      brand: json['brand'] ?? "",
      description: json['description'] ?? "",
      color: json['color'] ?? "",
      storage: json['storage'] ?? "",
      displaySize: json['display_size'] ?? "",
      processor: json['processor'] ?? "",
      operatingSystem: json['operating_system'] ?? "",
      batteryLife: json['battery_life'] ?? "",
      waterResistance: json['water_resistance'] ?? "",
      connectivity: json['connectivity'] ?? "",
      rating: json['rating'] ?? 0,
      quantity: 1, // Default quantity is 0
    );
  }

  Product copyWith({
    int? id,
    String? name,
    String? image,
    String? price,
    String? reviews,
    String? brand,
    String? description,
    String? color,
    String? storage,
    String? displaySize,
    String? processor,
    String? operatingSystem,
    String? batteryLife,
    String? waterResistance,
    String? connectivity,
    String? rating,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      reviews: reviews ?? this.reviews,
      brand: brand ?? this.brand,
      description: description ?? this.description,
      color: color ?? this.color,
      storage: storage ?? this.storage,
      displaySize: displaySize ?? this.displaySize,
      processor: processor ?? this.processor,
      operatingSystem: operatingSystem ?? this.operatingSystem,
      batteryLife: batteryLife ?? this.batteryLife,
      waterResistance: waterResistance ?? this.waterResistance,
      connectivity: connectivity ?? this.connectivity,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
    );
  }
  Product.empty()
      : id = 0,
        name = '',
        image = '',
        price = '',
        reviews = '',
        brand = '',
        description = '',
        color = '',
        storage = '',
        displaySize = '',
        processor = '',
        operatingSystem = '',
        batteryLife = '',
        waterResistance = '',
        connectivity = '',
        rating = '',
        quantity = 0;

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        price,
        reviews,
        brand,
        description,
        color,
        storage,
        displaySize,
        processor,
        operatingSystem,
        batteryLife,
        waterResistance,
        connectivity,
        rating,
        quantity,
      ];
}
