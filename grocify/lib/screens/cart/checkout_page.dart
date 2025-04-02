import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/data/shop.dart';
import 'package:grocify/main.dart';
import 'package:grocify/model/delivery_options.dart';
import 'package:grocify/providers/admin_provider.dart';
import 'package:grocify/providers/user_provider.dart';
import 'package:grocify/services/stripe_services.dart';
import 'package:grocify/widgets/cart/checkout_bottom_bar.dart';
import 'package:grocify/widgets/cart/delivery_options.dart';
import 'package:grocify/widgets/cart/order_summery.dart';
import 'package:grocify/widgets/cart/payment_method.dart';
import 'package:grocify/widgets/cart/shipping_info.dart';
import 'package:grocify/widgets/section_tile.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.cartTotal});

  final int cartTotal;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _paymentMethods = [
    'Credit/Debit Card',
    'Cash on Delivery',
  ];
  String _selectedPaymentMethod = 'Credit/Debit Card';

  final List<DeliveryOption> _deliveryOptions = [
    DeliveryOption(
      id: 'standard',
      name: 'Standard Delivery',
      price: 350.0,
      description: '3-5 business days',
    ),
    DeliveryOption(
      id: 'express',
      name: 'Express Delivery',
      price: 650.0,
      description: '1-2 business days',
    ),
  ];
  DeliveryOption? _selectedDeliveryOption;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _termsAccepted = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _selectedDeliveryOption = _deliveryOptions.first;

    final user = context.read<UserProvider>().user;

    _nameController.text = user!.username;
    _phoneController.text = user.contactNumber;
    _addressController.text = '123 Main Street, Apartment 4B';
    _cityController.text = 'Colombo';
    _postalCodeController.text = '00100';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  double get _subtotal => widget.cartTotal.toDouble();
  double get _deliveryFee => _selectedDeliveryOption?.price ?? 0;
  double get _total => _subtotal + _deliveryFee;

  void _processPayment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please accept the terms and conditions',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    await StripeService.instance.makePayment(
      context.read<UserProvider>().user!.username,
    );

    setState(() {
      _isProcessing = false;
    });

    _showOrderSuccessDialog();
  }

  void _showOrderSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Order Placed!',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your order has been placed successfully.',
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 8),
                Text(
                  'Order #: FN${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                Text(
                  'Thank you for shopping with Grocify!',
                  style: GoogleFonts.poppins(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<AdminProvider>().clearCart();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MyApp()),
                    (route) => false,
                  );
                },
                child: Text(
                  'Continue Shopping',
                  style: GoogleFonts.poppins(color: Colors.green),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<AdminProvider>().cart;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
          _isProcessing
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.green),
                    SizedBox(height: 16),
                    Text(
                      'Processing your payment...',
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
              )
              : Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Main scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Order summary
                            const SectionTitle(title: 'Order Summary'),
                            OrderSummary(
                              cartItems: cartItems,
                              subtotal: _subtotal,
                              deliveryFee: _deliveryFee,
                              total: _total,
                            ),

                            const SizedBox(height: 24),

                            // Shipping information
                            const SectionTitle(title: 'Shipping Information'),
                            ShippingInformationForm(
                              nameController: _nameController,
                              phoneController: _phoneController,
                              addressController: _addressController,
                              cityController: _cityController,
                              postalCodeController: _postalCodeController,
                            ),

                            const SizedBox(height: 24),

                            // Delivery options
                            const SectionTitle(title: 'Delivery Options'),
                            DeliveryOptionsSelector(
                              deliveryOptions: _deliveryOptions,
                              selectedDeliveryOption: _selectedDeliveryOption,
                              onChanged: (option) {
                                setState(() {
                                  _selectedDeliveryOption = option;
                                });
                              },
                            ),

                            const SizedBox(height: 24),

                            // Payment method
                            const SectionTitle(title: 'Payment Method'),
                            PaymentMethodSelector(
                              paymentMethods: _paymentMethods,
                              selectedPaymentMethod: _selectedPaymentMethod,
                              onChanged: (method) {
                                if (method != null) {
                                  setState(() {
                                    _selectedPaymentMethod = method;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 24),

                            // Terms and conditions
                            CheckboxListTile(
                              value: _termsAccepted,
                              onChanged: (value) {
                                setState(() {
                                  _termsAccepted = value!;
                                });
                              },
                              title: Text(
                                'I agree to the Terms and Conditions',
                                style: GoogleFonts.poppins(),
                              ),
                              activeColor: Colors.green,
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              dense: true,
                            ),

                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),

                    // Bottom payment bar
                    CheckoutBottomBar(
                      total: _total,
                      onPayPressed: _processPayment,
                    ),
                  ],
                ),
              ),
    );
  }
}
