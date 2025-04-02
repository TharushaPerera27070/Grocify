// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/model/product_model.dart';
import 'package:grocify/model/shop.dart';

class ProductInfoSection extends StatefulWidget {
  final ProductModel product;
  final int quantity;
  final Function(int) onQuantityChanged;

  const ProductInfoSection({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  State<ProductInfoSection> createState() => _ProductInfoSectionState();
}

class _ProductInfoSectionState extends State<ProductInfoSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.product.category,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Product name
          Text(
            widget.product.name,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // Rating
          Row(
            children: [
              for (int i = 0; i < 5; i++)
                Icon(
                  i < widget.product.rating.floor()
                      ? Icons.star
                      : i < widget.product.rating
                      ? Icons.star_half
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                ),
              const SizedBox(width: 8),
              Text(
                '${widget.product.rating} (${widget.product.reviewCount} reviews)',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Price
          Row(
            children: [
              Text(
                '\Rs.${widget.product.price}',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          // Availability
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                widget.product.isAvailable == "true"
                    ? Icons.check_circle
                    : Icons.cancel,
                color:
                    widget.product.isAvailable == "true"
                        ? Colors.green
                        : Colors.red,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                widget.product.isAvailable == "true"
                    ? 'In Stock'
                    : 'Out of Stock',
                style: GoogleFonts.poppins(
                  color:
                      widget.product.isAvailable == "true"
                          ? Colors.green
                          : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const Divider(height: 32),

          // Quantity selector
          Row(
            children: [
              Text(
                'Quantity',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed:
                          widget.quantity > 1
                              ? () =>
                                  widget.onQuantityChanged(widget.quantity - 1)
                              : null,
                      color: widget.quantity > 1 ? Colors.green : Colors.grey,
                      iconSize: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        '${widget.quantity}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed:
                          () => widget.onQuantityChanged(widget.quantity + 1),
                      color: Colors.green,
                      iconSize: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Description header
          Text(
            'Description',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            widget.product.description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
