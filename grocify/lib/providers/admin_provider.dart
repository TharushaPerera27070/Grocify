import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocify/model/product_model.dart';

import 'package:grocify/services/firebase_services.dart';
import 'package:image_picker/image_picker.dart';

class AdminProvider extends ChangeNotifier {
  List<ProductModel> products = [];
  List<ProductModel> cart = [];
  List<ProductModel> wishlist = [];
  List<ProductModel> searchResults = [];
  bool isLoading = false;
  File? productImage;

  final FirebaseService firebaseService = FirebaseService();

  Future<void> captureImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
      maxWidth: 1024,
      maxHeight: 1024,
    );

    if (photo != null) {
      productImage = File(photo.path);
      notifyListeners();
    }
  }

  Future<void> clearImage() async {
    productImage = null;
    notifyListeners();
  }

  String _generateProductId(String productName) {
    DateTime now = DateTime.now();
    String timestamp =
        "${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}";
    String sanitizedName =
        productName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
    return "${sanitizedName}_$timestamp";
  }

  Future<void> createProduct(ProductModel productData) async {
    try {
      isLoading = true;
      notifyListeners();

      String productId = _generateProductId(productData.name);

      String profilePictureURL = await firebaseService.uploadImage(
        productImage!,
        "Products",
        productId,
      );

      ProductModel product = ProductModel(
        id: productId,
        name: productData.name,
        price: productData.price,
        category: productData.category,
        isAvailable: productData.isAvailable,
        description: productData.description,
        imageURL: profilePictureURL,
        rating: productData.rating,
        reviewCount: productData.reviewCount,
        reviews: productData.reviews,
      );

      await firebaseService.uploadDocumentProduct(
        "Products",
        product,
        productId,
      );
      products.add(product);
      notifyListeners();
    } catch (error) {
      print("Error registering user: $error");
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      isLoading = true;
      notifyListeners();

      await firebaseService.deleteProduct(product.id, product.imageURL);

      removeProduct(product);
      notifyListeners();
    } catch (error) {
      print("Error deleting product: $error");
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      final productsList = await firebaseService.getDocuments("Products");
      products =
          productsList.docs.map((doc) => ProductModel.fromMap(doc)).toList();
      print('Fetched Products:');
      for (var product in products) {
        print('${product.name}: \$${product.price}');
      }
      notifyListeners();
    } catch (error) {
      print("Error fetching products: $error");
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addToWishlist(ProductModel product) {
    wishlist.add(product);
    notifyListeners();
  }

  void removeFromWishlist(ProductModel product) {
    wishlist.remove(product);
    notifyListeners();
  }

  void clearWishlist() {
    wishlist.clear();
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    cart.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    cart.remove(product);
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  void addProduct(ProductModel product) {
    products.add(product);
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    products.remove(product);
    notifyListeners();
  }

  void updateProduct(ProductModel oldProduct, ProductModel newProduct) {
    int index = products.indexOf(oldProduct);
    if (index != -1) {
      products[index] = newProduct;
      notifyListeners();
    }
  }

  void clearProducts() {
    products.clear();
    notifyListeners();
  }

  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      searchResults = List.from(products);
    } else {
      searchResults =
          products
              .where(
                (product) =>
                    product.name.toLowerCase().contains(query.toLowerCase()) ||
                    product.description.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    searchResults = []; // Changed from List.from(products) to empty list
    notifyListeners();
  }
}
