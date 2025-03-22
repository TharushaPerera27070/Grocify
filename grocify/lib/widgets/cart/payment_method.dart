import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodSelector extends StatelessWidget {
  final List<String> paymentMethods;
  final String selectedPaymentMethod;
  final ValueChanged<String?> onChanged;

  const PaymentMethodSelector({
    super.key,
    required this.paymentMethods,
    required this.selectedPaymentMethod,
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
              paymentMethods
                  .map(
                    (method) => RadioListTile<String>(
                      title: Text(
                        method,
                        style: GoogleFonts.marcellus(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: method,
                      groupValue: selectedPaymentMethod,
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
