import 'package:grocify/model/shop.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class ProductData {
  static final List<Product> _products = [
    Product(
      id: '30',
      name: 'Mango',
      category: 'Fruits',
      price: 120,
      description:
          'Mango is a juicy stone fruit produced from numerous species of tropical trees belonging to the flowering plant genus Mangifera, cultivated mostly for their edible fruit.',
      imageUrl: 'assets/mango.jpg',
      rating: 4.8,
      reviewCount: 245,
      inStock: true,
      relatedProducts: ['31', '32'],
      reviews: [
        Review(
          id: "r001",
          userName: "Samantha Baddage",
          //userImage: "",
          rating: 5.0,
          comment:
              "This product is amazing! The quality is top-notch and I highly recommend it!",
          date: DateTime(2024, 12, 23),
        ),
        Review(
          id: "r002",
          userName: "Upali Fernando",
          rating: 4.0,
          comment: "I love this product! It's tastes really good.",
          date: DateTime(2025, 02, 28),
          images: ["assets/images.jpg"],
          helpfulCount: 12,
        ),
        Review(
          id: "r003",
          userName: "Thimali Perera",
          rating: 4.5,
          comment: "The quality is top-notch and tastes fresh!",
          date: DateTime(2025, 03, 02),
          helpfulCount: 5,
        ),
      ],
    ),
    Product(
      id: '31',
      name: 'Apple',
      category: 'Fruits',
      price: 200,
      description:
          'Apple is a sweet, edible fruit produced by an apple tree. Apple trees are cultivated worldwide and are the most widely grown species in the genus Malus.',
      imageUrl: 'assets/apple.jpg',
      rating: 4.7,
      reviewCount: 310,
      inStock: true,
      relatedProducts: ['30', '32'],
      reviews: [
        Review(
          id: "r001",
          userName: "Anushka Udana",
          rating: 5.0,
          comment:
              "This product is amazing! The quality is top-notch and I highly recommend it!",
          date: DateTime(2024, 12, 23),
        ),
        Review(
          id: "r002",
          userName: "Ruwan Fernando",
          rating: 4.0,
          comment: "I love this product! It's tastes really good.",
          date: DateTime(2025, 02, 28),
          //images: ["assets/images/review1_1.jpg"],
          helpfulCount: 12,
        ),
        Review(
          id: "r003",
          userName: "Kavindu Perera",
          rating: 4.5,
          comment: "The quality is top-notch and tastes fresh!",
          date: DateTime(2025, 03, 02),
          helpfulCount: 5,
        ),
      ],
    ),
    Product(
      id: '32',
      name: 'Pineapple',
      category: 'Fruits',
      price: 300,
      description:
          'Pineapple is a tropical plant with an edible fruit and the most economically significant plant in the family Bromeliaceae.',
      imageUrl: 'assets/pineapple.png',
      rating: 4.9,
      reviewCount: 198,
      inStock: true,
      relatedProducts: ['30', '31'],
      reviews: [
        Review(
          id: "r004",
          userName: "Nimesha Perera",
          rating: 4.5,
          comment:
              "The quality is top-notch and tastes fresh! I would definitely recommend it.",
          date: DateTime(2025, 03, 10),
        ),
        Review(
          id: "r005",
          userName: "Samantha Jayasuriya",
          rating: 4.0,
          comment: "I love this product! It's tastes really good",
          date: DateTime(2025, 02, 25),
          helpfulCount: 8,
        ),
      ],
    ),
    Product(
      id: '33',
      name: 'Banana',
      category: 'Fruits',
      price: 380,
      description:
          'Banana is an elongated, edible fruit produced by several kinds of large herbaceous flowering plants in the genus Musa.',
      imageUrl: 'assets/banana-apple-manzano-exoticfruitscouk-905674.jpg',
      rating: 4.6,
      reviewCount: 275,
      inStock: true,
      relatedProducts: ['31', '32'],
      reviews: [
        Review(
          id: "r006",
          userName: "Chamathka Silva",
          rating: 5.0,
          comment:
              "I absolutely love this product! The quality is top-notch and tastes fresh!",
          date: DateTime(2024, 11, 05),
        ),
      ],
    ),
    Product(
      id: '34',
      name: 'Cabbage',
      category: 'Vegetables',
      price: 150,
      description:
          'Cabbage is a leafy green, red, or white biennial plant grown as an annual vegetable crop for its dense-leaved heads.',
      imageUrl: 'assets/cabbage.jpg',
      rating: 4.5,
      reviewCount: 400,
      inStock: true,
      relatedProducts: ['36', '35'],
      reviews: [
        Review(
          id: "r007",
          userName: "Dilki Perera",
          rating: 4.5,
          comment: "Love this product!",
          date: DateTime(2024, 03, 08),
        ),
      ],
    ),
    Product(
      id: '35',
      name: 'Beetroot',
      category: 'Vegetables',
      price: 50,
      description:
          'Beetroot is the taproot portion of a beet plant, usually known in Canada and the USA as beets while the vegetable is referred to as beetroot in British English.',
      imageUrl: 'assets/beetroot.jpg',
      rating: 4.8,
      reviewCount: 220,
      inStock: true,
      relatedProducts: ['36', '34'],
      reviews: [
        Review(
          id: "r008",
          userName: "Kasun Perera",
          rating: 4.5,
          comment:
              "The quality is top-notch and tastes fresh! I would definitely recommend it.",
          date: DateTime(2025, 03, 10),
        ),
        Review(
          id: "r009",
          userName: "Thamalka De Silva",
          rating: 4.5,
          comment: "The quality is top-notch and tastes fresh!",
          date: DateTime(2025, 03, 23),
        ),
      ],
    ),
    Product(
      id: '36',
      name: 'Beans',
      category: 'Vegetables',
      price: 90,
      description:
          'Beans are one of the longest-cultivated plants. Broad beans, also called fava beans, in their wild state the size of a small fingernail, were gathered in Afghanistan and the Himalayan foothills.',
      imageUrl: 'assets/beans.jpeg',
      rating: 4.7,
      reviewCount: 300,
      inStock: true,
      relatedProducts: ['34', '35'],
      reviews: [
        Review(
          id: "r009",
          userName: "Udana Kumara",
          rating: 4.5,
          comment:
              "The quality is top-notch and tastes fresh! I would definitely recommend it.",
          date: DateTime(2025, 03, 10),
        ),
        Review(
          comment: "The quality is top-notch and tastes fresh!",
          date: DateTime(2025, 03, 23),
          id: "r010",
          rating: 4.5,
          userName: "Shammika Silva",
        ),
      ],
    ),
    Product(
      id: '37',
      name: 'Dhal',
      category: 'Grocery',
      price: 250,
      description:
          'Dhal is a term used in the Indian subcontinent for dried, split pulses that do not require soaking before cooking.',
      imageUrl: 'assets/dhal.jpg',
      rating: 4.6,
      reviewCount: 150,
      inStock: true,
      relatedProducts: ['38', '39'],
      reviews: [
        Review(
          id: "r010",
          userName: "Kasun Geesara",
          rating: 4.5,
          comment: "The quality good! Deliverd within 2 days too.",
          date: DateTime(2025, 03, 10),
        ),
        Review(
          id: "r011",
          userName: "Kavindu Perera",
          rating: 4.5,
          comment: "The quality good and the price is reasonable.",
          date: DateTime(2025, 03, 10),
        ),
      ],
    ),
    Product(
      id: '38',
      name: 'Rice',
      category: 'Grocery',
      price: 350,
      description:
          'Rice is the seed of the grass species Oryza sativa or less commonly Oryza glaberrima. As a cereal grain, it is the most widely consumed staple food for a large part of the world\'s human population, especially in Asia and Africa. It is the agricultural commodity with the third-highest worldwide production.',
      imageUrl: 'assets/rice.jpg',
      rating: 4.6,
      reviewCount: 150,
      inStock: true,
      relatedProducts: ['39', '37'],
      reviews: [
        Review(
          id: "r011",
          userName: "Monal Lanka",
          rating: 4.5,
          comment: "The quality good and the price is reasonable.",
          date: DateTime(2025, 03, 10),
        ),
        Review(
          id: "r012",
          userName: "Frank Perera",
          rating: 4.5,
          comment: "The quality good! Deliverd within 2 days too.",
          date: DateTime(2025, 03, 10),
        ),
      ],
    ),
    Product(
      id: '39',
      name: 'Oil',
      category: 'Grocery',
      price: 750,
      description:
          'An oil is any nonpolar chemical substance that is a viscous liquid at ambient temperatures and is both hydrophobic and lipophilic. Oils have a high carbon and hydrogen content and are usually flammable and surface active.',
      imageUrl: 'assets/oil.jpg',
      rating: 4.6,
      reviewCount: 150,
      inStock: true,
      relatedProducts: ['37', '38'],
      reviews: [
        Review(
          id: "r012",
          userName: "Kavya Kumara",
          rating: 4.5,
          comment: "The quality good and the price is reasonable.",
          date: DateTime(2025, 03, 10),
        ),
        Review(
          id: "r013",
          userName: "Kasun Kanchana",
          rating: 4.5,
          comment: "The quality good! Deliverd within 2 days too.",
          date: DateTime(2025, 03, 10),
        ),
      ],
    ),
  ];

  static List<Product> getAllProducts() {
    return _products;
  }

  // Get products by category
  static List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  // Get product by ID
  static Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null; // Product not found
    }
  }

  // Search products
  static List<Product> searchProducts(String query) {
    if (query.isEmpty) {
      return _products;
    }

    final lowerQuery = query.toLowerCase();
    return _products.where((product) {
      return product.name.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery) ||
          product.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Get featured products (for example, ones with ratings > 4.7)
  static List<Product> getFeaturedProducts() {
    return _products.where((product) => product.rating > 4.7).toList();
  }

  // Get categories
  static List<String> getCategories() {
    final categories =
        _products.map((product) => product.category).toSet().toList();
    return categories;
  }

  // List to store favorite products
  static final List<Product> _favorites = [];

  // Get all favorite products
  static List<Product> get favorites => List.unmodifiable(_favorites);

  // Add a product to favorites
  static void addToFavorites(Product product) {
    if (!_favorites.contains(product)) {
      product.isFavorite = true;
      _favorites.add(product);
    }
  }

  // Remove a product from favorites
  static void removeFromFavorites(Product product) {
    product.isFavorite = false;
    _favorites.remove(product);
  }

  // Check if a product is in favorites
  static bool isFavorite(String productId) {
    // This is more efficient than iterating through the entire list
    return _favorites.any((product) => product.id == productId);
  }

  // Cart item class to store product and quantity
  static CartItem createCartItem({
    required Product product,
    required int quantity,
  }) {
    return CartItem(product: product, quantity: quantity);
  }

  // List to store cart items
  static final List<CartItem> _cartItems = [];

  // Get all cart items
  static List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  // Get total number of items in cart
  static int get cartItemCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // Get total price of cart
  static double get cartTotal {
    return _cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  // Add a product to cart
  static void addToCart(Product product, int quantity) {
    // Check if product already in cart
    final existingItemIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingItemIndex != -1) {
      // Update quantity if already in cart
      _cartItems[existingItemIndex].quantity += quantity;
    } else {
      // Add new item to cart
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }
  }

  // Update quantity of a product in cart
  static void updateCartItemQuantity(String productId, int newQuantity) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = newQuantity;
      }
    }
  }

  // Remove an item from cart
  static void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
  }

  // Clear the cart
  static void clearCart() {
    _cartItems.clear();
  }
}
