import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/model/product_model.dart';
import 'package:grocify/model/shop.dart';
import 'package:grocify/providers/admin_provider.dart';
import 'package:grocify/providers/user_provider.dart';
import 'package:grocify/services/stripe_services.dart';
import 'package:grocify/widgets/product_details/bottom_purchase_bar.dart';
import 'package:grocify/widgets/product_details/product_image_viewer.dart';
import 'package:grocify/widgets/product_details/product_info.dart';
import 'package:grocify/widgets/product_details/reviews_section.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _selectedImageIndex = 0;
  int _quantity = 1;
  final TextEditingController _reviewController = TextEditingController();
  double _userRating = 0;
  final List<Review> _temporaryReviews = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    final adminProvider = context.read<AdminProvider>();
    bool isInWishlist = adminProvider.wishlist.any(
      (item) => item.id == widget.product.id,
    );

    if (isInWishlist) {
      adminProvider.removeFromWishlist(widget.product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed from wishlist', style: GoogleFonts.poppins()),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      adminProvider.addToWishlist(widget.product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to wishlist', style: GoogleFonts.poppins()),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _addToCart() {
    bool isInCart = context.read<AdminProvider>().cart.any(
      (item) => item.id == widget.product.id,
    );
    if (!isInCart) {
      context.read<AdminProvider>().addToCart(widget.product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to cart', style: GoogleFonts.poppins()),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Product already in cart',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.grey,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _buyNow() async {
    context.read<AdminProvider>().toggleLoading();
    await StripeService.instance.makePayment(
      context.read<UserProvider>().user!.username,
    );
    context.read<AdminProvider>().toggleLoading();

    Navigator.of(context).pop();
  }

  void _submitReview() {
    if (_reviewController.text.isEmpty || _userRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please add a review and rating',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _temporaryReviews.insert(
        0,
        Review(
          id: DateTime.now().toString(),
          userName: context.read<UserProvider>().user?.username ?? "Anonymous",
          rating: _userRating,
          comment: _reviewController.text,
          date: DateTime.now(),
        ),
      );
    });

    _reviewController.clear();
    setState(() {
      _userRating = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Review submitted successfully',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isInWishlist = context.watch<AdminProvider>().wishlist.any(
      (item) => item.id == widget.product.id,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: isInWishlist ? Colors.red : Colors.black,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageViewer(mainImage: widget.product.imageURL),
                  ProductInfoSection(
                    product: widget.product,
                    quantity: _quantity,
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        _quantity = newQuantity;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Write a Review',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                index < _userRating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                              ),
                              onPressed: () {
                                setState(() {
                                  _userRating = index + 1;
                                });
                              },
                            );
                          }),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _reviewController,
                          maxLines: 3,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            hintText:
                                'Share your thoughts about this product...',
                            border: OutlineInputBorder(),
                            hintStyle: GoogleFonts.poppins(),
                            focusColor: Colors.green,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: _submitReview,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                          ),
                          child: Text(
                            'Submit Review',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ReviewsSection(
                    reviews: [
                      ..._temporaryReviews,
                      Review(
                        id: "r012",
                        userName: "Kavya Kumara",
                        rating: 4.5,
                        comment:
                            "The quality good and the price is reasonable.",
                        date: DateTime(2025, 03, 10),
                      ),
                      Review(
                        id: "r013",
                        userName: "Kasun Kanchana",
                        rating: 4.5,
                        comment:
                            "The quality good! Deliverd within 2 days too.",
                        date: DateTime(2025, 03, 10),
                      ),
                    ],
                    rating: widget.product.rating,
                    reviewCount:
                        widget.product.reviewCount + _temporaryReviews.length,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          BottomPurchaseBar(
            inStock: widget.product.isAvailable == 'true',
            onAddToCart: _addToCart,
            onBuyNow: _buyNow,
          ),
        ],
      ),
    );
  }
}
