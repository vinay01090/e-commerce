import 'dart:convert';
import 'package:amazon_clone/models/rating.dart';

class Product {
  final String name;
  final String description;
  final List<String>images;
  final double quantity;
  final double price;
  final String category;
  final String? id;
  final List<Rating>?rating; 
  Product({
    required this.name,
    required this.description,
    required this.images,
    required this.quantity,
    required this.price,
    required this.category,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'images': images,
       'quantity': quantity,
       'price': price,
      'category': category,
      'id': id,
      'rating':rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      images: List<String>.from(map['images']),
      quantity: map['quantity']?.toDouble() ?? 0.0,
      price: map['price']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      id: map['_id'],
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}