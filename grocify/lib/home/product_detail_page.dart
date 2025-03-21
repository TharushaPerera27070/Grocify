import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/data/shop.dart';
import 'package:grocify/model/shop.dart';
import 'package:grocify/widgets/product_details/bottom_purchase_bar.dart';
import 'package:grocify/widgets/product_details/product_image_viewer.dart';
import 'package:grocify/widgets/product_details/product_info.dart';
import 'package:grocify/widgets/product_details/related_products.dart';
import 'package:grocify/widgets/product_details/specifications_section.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Product _product;
  bool _isLoading = true;
  bool _isFavorite = false;
  int _quantity = 1;
  int _selectedImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _loadProduct() async {
    // Simulate network loading
    await Future.delayed(const Duration(milliseconds: 500));

    final product = ProductData.getProductById(widget.productId);

    if (product != null) {
      setState(() {
        _product = product;
        _isFavorite = product.isFavorite;
        _isLoading = false;
      });
    } else {
      // Handle product not found
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;

      // Update the product's isFavorite property
      _product.isFavorite = _isFavorite;

      // Add or remove from favorites collection
      if (_isFavorite) {
        ProductData.addToFavorites(_product);
      } else {
        ProductData.removeFromFavorites(_product);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? 'Added to favorites' : 'Removed from favorites',
          style: GoogleFonts.marcellus(),
        ),
        backgroundColor: const Color.fromARGB(255, 165, 81, 139),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _addToCart() {
    // Add the product to cart with the selected quantity
    ProductData.addToCart(_product, _quantity);

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added $_quantity ${_product.name} to cart',
          style: GoogleFonts.marcellus(),
        ),
        backgroundColor: const Color.fromARGB(255, 165, 81, 139),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _buyNow() {
    // In a real app, you would navigate to checkout
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Proceeding to checkout...',
          style: GoogleFonts.marcellus(),
        ),
        backgroundColor: const Color.fromARGB(255, 165, 81, 139),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Product Details',
            style: GoogleFonts.marcellus(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 165, 81, 139),
          ),
        ),
      );
    }

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
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color:
                  _isFavorite
                      ? const Color.fromARGB(255, 165, 81, 139)
                      : Colors.black,
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
                  ProductImageViewer(
                    mainImage: _product.imageUrl,
                    additionalImages: _product.additionalImages,
                    selectedIndex: _selectedImageIndex,
                    onImageSelected: (index) {
                      setState(() {
                        _selectedImageIndex = index;
                      });
                    },
                  ),

                  ProductInfoSection(
                    product: _product,
                    quantity: _quantity,
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        _quantity = newQuantity;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  SpecificationsSection(
                    specifications: _product.specifications,
                  ),

                  const SizedBox(height: 24),

                  RelatedProductsSection(
                    relatedProductIds: _product.relatedProducts,
                  ),
                ],
              ),
            ),
          ),

          BottomPurchaseBar(
            inStock: _product.inStock,
            onAddToCart: _addToCart,
            onBuyNow: _buyNow,
          ),
        ],
      ),
    );
  }
}
