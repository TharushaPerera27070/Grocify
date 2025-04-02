import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/providers/admin_provider.dart';
import 'package:provider/provider.dart';

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
                side: BorderSide(color: inStock ? Colors.green : Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Add to Cart',
                style: GoogleFonts.poppins(
                  color: inStock ? Colors.green : Colors.grey,
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
                backgroundColor:
                    context.watch<AdminProvider>().isLoading
                        ? Colors.grey
                        : Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child:
                  context.watch<AdminProvider>().isLoading
                      ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                      : Text(
                        'Buy Now',
                        style: GoogleFonts.poppins(
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
