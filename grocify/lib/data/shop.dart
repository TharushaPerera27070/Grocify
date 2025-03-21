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
      name: 'mango',
      category: 'Fruits',
      price: 7200,
      description:
          'Lightweight and breathable summer dress with a floral print, perfect for casual outings and warm weather.',
      imageUrl: 'assets/summer.jpg',
      rating: 4.8,
      reviewCount: 245,
      inStock: true,
      features: [
        'Soft and breathable fabric',
        'Flattering A-line silhouette',
        'Available in multiple floral prints',
        'Sizes XS to XL available',
        'Perfect for summer and spring wear',
      ],
      specifications: {
        'Material': 'Cotton blend',
        'Pattern': 'Floral',
        'Sizes': 'XS, S, M, L, XL',
        'Care': 'Machine washable, cold water',
        'Colors': 'Blue, Pink, Yellow, White',
      },
      relatedProducts: ['31', '32'],
    ),
    Product(
      id: '31',
      name: 'apple',
      category: 'Fruits',
      price: 8500,
      description:
          'Classic high-waisted jeans with a flattering slim fit, designed for everyday comfort and style.',
      imageUrl: 'assets/jeans.jpg',
      rating: 4.7,
      reviewCount: 310,
      inStock: true,
      features: [
        'Stretchable denim material',
        'Slim and flattering fit',
        'High-rise waistband for extra comfort',
        'Available in multiple washes',
        'Sizes 24 to 34 available',
      ],
      specifications: {
        'Material': 'Denim (Cotton & Elastane blend)',
        'Fit': 'Slim fit, high-rise',
        'Sizes': '24, 26, 28, 30, 32, 34',
        'Care': 'Machine washable, tumble dry low',
        'Colors': 'Light Blue, Dark Blue, Black',
      },
      relatedProducts: ['30', '32'],
    ),
    Product(
      id: '32',
      name: 'pineapple',
      category: 'Fruits',
      price: 6500,
      description:
          'Cozy oversized knitted sweater, perfect for chilly days and layering over any outfit.',
      imageUrl: 'assets/sweter.jpg',
      rating: 4.9,
      reviewCount: 198,
      inStock: true,
      features: [
        'Soft and warm knitted fabric',
        'Relaxed oversized fit',
        'Versatile styling for all occasions',
        'Available in neutral colors',
        'Sizes S to XXL available',
      ],
      specifications: {
        'Material': 'Acrylic and Wool blend',
        'Fit': 'Oversized',
        'Sizes': 'S, M, L, XL, XXL',
        'Care': 'Hand wash recommended, lay flat to dry',
        'Colors': 'Beige, Gray, Brown, White',
      },
      relatedProducts: ['30', '31'],
    ),
    Product(
      id: '33',
      name: 'banana',
      category: 'Fruits',
      price: 3800,
      description:
          'A stylish striped midi skirt, perfect for a chic and casual look. It pairs well with a variety of tops.',
      imageUrl: 'assets/5051839723887_3.jpg',
      rating: 4.6,
      reviewCount: 275,
      inStock: true,
      features: [
        'Soft and flowy fabric',
        'Elastic waistband for comfort',
        'Mid-length design',
        'Easy to pair with any top',
        'Ideal for both casual and semi-formal events',
      ],
      specifications: {
        'Material': 'Polyester blend',
        'Pattern': 'Striped',
        'Sizes': 'S, M, L, XL',
        'Care': 'Machine washable, gentle cycle',
        'Colors': 'Black & White, Blue & White, Red & White',
      },
      relatedProducts: ['34', '35'],
    ),
    Product(
      id: '34',
      name: 'Gowa',
      category: 'Vegetables',
      price: 1500,
      description:
          'A simple, comfortable white T-shirt that every wardrobe needs. It’s a versatile piece for any occasion.',
      imageUrl: 'assets/premium_photo-1690349404224-53f94f20df8f.jpg',
      rating: 4.5,
      reviewCount: 400,
      inStock: true,
      features: [
        'Soft cotton fabric',
        'Classic round neckline',
        'Available in various sizes',
        'Breathable and lightweight',
        'Perfect for layering or wearing alone',
      ],
      specifications: {
        'Material': 'Cotton',
        'Fit': 'Regular fit',
        'Sizes': 'XS, S, M, L, XL, XXL',
        'Care': 'Machine washable, tumble dry low',
        'Colors': 'White, Black, Navy, Gray',
      },
      relatedProducts: ['33', '35'],
    ),
    Product(
      id: '35',
      name: 'Leather Crossbody Bag',
      category: 'Vegetables',
      price: 9500,
      description:
          'A stylish and practical leather crossbody bag that complements any outfit, with plenty of room for your essentials.',
      imageUrl: 'assets/Willow-brown-leather-sling-bag-brown-model+(12).jpg',
      rating: 4.8,
      reviewCount: 220,
      inStock: true,
      features: [
        'High-quality leather',
        'Adjustable shoulder strap',
        'Multiple interior pockets for organization',
        'Sleek and versatile design',
        'Perfect for daily use or special occasions',
      ],
      specifications: {
        'Material': 'Genuine leather',
        'Dimensions': 'L 25cm, H 18cm, W 8cm',
        'Closure': 'Zipper',
        'Care': 'Spot clean with a damp cloth',
        'Colors': 'Black, Brown, Tan',
      },
      relatedProducts: ['33', '34'],
    ),
    Product(
      id: '36',
      name: 'Floral Wrap Dress',
      category: 'Grocery',
      price: 7900,
      description:
          'A beautiful floral wrap dress with a flattering silhouette, perfect for day-to-night wear.',
      imageUrl: 'assets/ae6a1ca0-06f5-4c1d-b746-d6a29e68.jpg',
      rating: 4.7,
      reviewCount: 300,
      inStock: true,
      features: [
        'Flattering wrap design',
        'Soft and lightweight fabric',
        'Perfect for a variety of occasions',
        'Available in several floral patterns',
        'Sizes XS to L available',
      ],
      specifications: {
        'Material': 'Rayon blend',
        'Pattern': 'Floral',
        'Sizes': 'XS, S, M, L',
        'Care': 'Machine washable, cold water',
        'Colors': 'Pink Floral, Blue Floral, Green Floral',
      },
      relatedProducts: ['30', '32'],
    ),
    Product(
      id: '37',
      name: 'Comfortable Leggings',
      category: 'Grocery',
      price: 2500,
      description:
          'Stretchable leggings designed for maximum comfort and flexibility. Ideal for workouts or casual wear.',
      imageUrl: 'assets/celeste1.1.jpg',
      rating: 4.6,
      reviewCount: 150,
      inStock: true,
      features: [
        'High-waisted for extra support',
        'Elastic waistband for a secure fit',
        'Stretchable fabric for flexibility',
        'Perfect for yoga, workouts, or casual wear',
        'Available in multiple colors',
      ],
      specifications: {
        'Material': 'Spandex and Polyester blend',
        'Fit': 'Slim fit, high-waisted',
        'Sizes': 'S, M, L, XL',
        'Care': 'Machine washable, gentle cycle',
        'Colors': 'Black, Navy, Gray, Burgundy',
      },
      relatedProducts: ['31', '34'],
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
