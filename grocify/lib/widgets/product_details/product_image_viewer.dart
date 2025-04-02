import 'package:flutter/material.dart';

class ProductImageViewer extends StatefulWidget {
  final String mainImage;

  const ProductImageViewer({super.key, required this.mainImage});

  @override
  State<ProductImageViewer> createState() => _ProductImageViewerState();
}

class _ProductImageViewerState extends State<ProductImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main image
        SizedBox(
          height: 300,
          width: double.infinity,
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/Grocify_bg.png',
            image: widget.mainImage,
            width: double.infinity,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
            placeholderFit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 500),
            fadeInCurve: Curves.easeIn,
          ),
        ),

        // Image selector
      ],
    );
  }
}
