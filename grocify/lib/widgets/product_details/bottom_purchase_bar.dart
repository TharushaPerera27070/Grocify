import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomPurchaseBar extends StatelessWidget {
  final bool inStock;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  const BottomPurchaseBar({
    super.key,
    required this.inStock,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Add to cart button
          Expanded(
            child: OutlinedButton(
              onPressed: inStock ? onAddToCart : null,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color:
                      inStock
                          ? const Color.fromARGB(255, 165, 81, 139)
                          : Colors.grey,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Add to Cart',
                style: GoogleFonts.marcellus(
                  color:
                      inStock
                          ? const Color.fromARGB(255, 165, 81, 139)
                          : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Buy now button
          Expanded(
            child: ElevatedButton(
              onPressed: inStock ? onBuyNow : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 165, 81, 139),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Buy Now',
                style: GoogleFonts.marcellus(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
