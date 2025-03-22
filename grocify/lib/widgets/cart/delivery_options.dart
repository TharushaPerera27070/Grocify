import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/model/delivery_options.dart';

class DeliveryOptionsSelector extends StatelessWidget {
  final List<DeliveryOption> deliveryOptions;
  final DeliveryOption? selectedDeliveryOption;
  final ValueChanged<DeliveryOption?> onChanged;

  const DeliveryOptionsSelector({
    super.key,
    required this.deliveryOptions,
    required this.selectedDeliveryOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children:
              deliveryOptions
                  .map(
                    (option) => RadioListTile<DeliveryOption>(
                      title: Text(
                        option.name,
                        style: GoogleFonts.marcellus(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        option.description,
                        style: GoogleFonts.marcellus(
                          color: Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                      secondary: Text(
                        'Rs.${option.price.toStringAsFixed(2)}',
                        style: GoogleFonts.marcellus(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: option,
                      groupValue: selectedDeliveryOption,
                      activeColor: const Color.fromARGB(255, 165, 81, 139),
                      onChanged: onChanged,
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
