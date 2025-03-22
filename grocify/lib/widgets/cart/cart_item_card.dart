import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/data/shop.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    return Dismissible(
      key: Key(product.id.toString()),
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
        ProductData.removeFromCart(product.id);
        onQuantityChanged();
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
                  child: Image.asset(
                    product.imageUrl,
                    width: 120,
                    height: 125,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                // Product details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rs.${product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
            // Quantity selector
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (item.quantity > 1) {
                        ProductData.updateCartItemQuantity(
                          product.id,
                          item.quantity - 1,
                        );
                      } else {
                        ProductData.removeFromCart(product.id);
                      }
                      onQuantityChanged();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),

                      child: const Icon(
                        Icons.remove,
                        size: 20,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Quantity
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),

                    child: Text(
                      '${item.quantity}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Increase button
                  InkWell(
                    onTap: () {
                      ProductData.updateCartItemQuantity(
                        product.id,
                        item.quantity + 1,
                      );
                      onQuantityChanged();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),

                      child: const Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
