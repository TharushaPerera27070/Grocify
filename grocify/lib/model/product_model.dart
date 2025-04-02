import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocify/model/shop.dart';

class ProductModel {
  final String id;
  final String name;
  final String price;
  final String category;
  final String isAvailable;
  final String description;
  final String imageURL;
  final double rating;
  final int reviewCount;
  final List<Review>? reviews;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.isAvailable,
    required this.description,
    required this.imageURL,
    required this.rating,
    required this.reviewCount,
    required this.reviews,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'isAvailable': isAvailable,
      'description': description,
      'imageURL': imageURL,
      'rating': rating,
      'reviewCount': reviewCount,
      'reviews': reviews,
    };
  }

  factory ProductModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    List<Review>? reviewsList;
    if (data['reviews'] != null) {
      reviewsList =
          (data['reviews'] as List)
              .map((reviewData) => Review.fromMap(reviewData))
              .toList();
    }

    return ProductModel(
      id: doc.id,
      name: data['name'] ?? '',
      price: data['price'] ?? '',
      category: data['category'] ?? '',
      isAvailable: data['isAvailable'] ?? '',
      description: data['description'] ?? '',
      imageURL: data['imageURL'] ?? '',
      rating: data['rating']?.toDouble() ?? 0.0,
      reviewCount: data['reviewCount']?.toInt() ?? 0,
      reviews: reviewsList,
    );
  }
}
