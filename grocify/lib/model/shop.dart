import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? originalPrice;
  final String description;
  final String imageUrl;
  final List<String>? additionalImages;
  final double rating;
  final int reviewCount;
  final bool inStock;
  bool isFavorite;
  final List<String>? relatedProducts;
  final List<Review>? reviews;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.description,
    required this.imageUrl,
    this.additionalImages,
    required this.rating,
    required this.reviewCount,
    required this.inStock,
    this.isFavorite = false,
    this.relatedProducts,
    this.reviews,
  });
}

class Review {
  final String id;
  final String userName;
  final String? userImage;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String>? images;
  final int helpfulCount;

  Review({
    required this.id,
    required this.userName,
    this.userImage,
    required this.rating,
    required this.comment,
    required this.date,
    this.images,
    this.helpfulCount = 0,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] ?? '',
      userName: map['userName'] ?? '',
      userImage: map['userImage'],
      rating: (map['rating'] ?? 0).toDouble(),
      comment: map['comment'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      images: List<String>.from(map['images'] ?? []),
      helpfulCount: map['helpfulCount'] ?? 0,
    );
  }
}
