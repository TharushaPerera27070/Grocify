import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecificationsSection extends StatelessWidget {
  final Map<String, String>? specifications;

  const SpecificationsSection({super.key, required this.specifications});

  @override
  Widget build(BuildContext context) {
    if (specifications == null || specifications!.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Specifications',
            style: GoogleFonts.marcellus(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children:
                  specifications!.entries.map((entry) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              entry.key,
                              style: GoogleFonts.marcellus(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              entry.value,
                              style: GoogleFonts.marcellus(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
