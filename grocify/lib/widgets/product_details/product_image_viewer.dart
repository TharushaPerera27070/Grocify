import 'package:flutter/material.dart';

class ProductImageViewer extends StatefulWidget {
  final String mainImage;
  final List<String>? additionalImages;
  final Function(int) onImageSelected;
  final int selectedIndex;

  const ProductImageViewer({
    super.key,
    required this.mainImage,
    this.additionalImages,
    required this.onImageSelected,
    required this.selectedIndex,
  });

  @override
  State<ProductImageViewer> createState() => _ProductImageViewerState();
}

class _ProductImageViewerState extends State<ProductImageViewer> {
  @override
  Widget build(BuildContext context) {
    // List of all images (main + additional)
    final allImages = [widget.mainImage];
    if (widget.additionalImages != null) {
      allImages.addAll(widget.additionalImages!);
    }

    return Column(
      children: [
        // Main image
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Image.asset(
            allImages[widget.selectedIndex],
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                ),
              );
            },
          ),
        ),

        // Image selector
        if (allImages.length > 1)
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: allImages.length,
              itemBuilder: (context, index) {
                final isSelected = widget.selectedIndex == index;
                return GestureDetector(
                  onTap: () => widget.onImageSelected(index),
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            isSelected
                                ? const Color.fromARGB(255, 165, 81, 139)
                                : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(allImages[index], fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
