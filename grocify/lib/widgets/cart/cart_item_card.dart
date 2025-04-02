import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/data/shop.dart';
import 'package:grocify/model/product_model.dart';
import 'package:grocify/providers/admin_provider.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatefulWidget {
  final ProductModel item;
  final VoidCallback onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.item.id),
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<AdminProvider>().removeFromCart(widget.item);
        widget.onQuantityChanged();
      },
      child: Card(
        surfaceTintColor: Colors.green,
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Product image
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/Grocify_bg.png',
                    image: widget.item.imageURL,
                    width: 120,
                    height: 125,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                    placeholderFit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeInCurve: Curves.easeIn,
                  ),
                ),
                SizedBox(width: 16),
                // Product details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rs.${widget.item.price}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      color: Colors.amber,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Slide to remove",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Quantity selector
          ],
        ),
      ),
    );
  }
}
