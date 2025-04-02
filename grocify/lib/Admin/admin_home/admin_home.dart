import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/Admin/admin_home/add_product_page.dart';
import 'package:grocify/data/shop.dart';
import 'package:grocify/model/shop.dart';
import 'package:grocify/providers/admin_provider.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int get totalProducts => ProductData.getAllProducts().length;

  List<Product> get recentProducts {
    final products = ProductData.getAllProducts();
    products.sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id)));
    return products.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Manage your products and monitor store activity here',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade800,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 20),
                _buildStatsColumn(),
                const SizedBox(height: 42),
                SizedBox(
                  width: double.infinity,
                  height: 75,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddProductPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      side: WidgetStatePropertyAll(
                        BorderSide(color: Colors.green, width: 2),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      '+ Add Product',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Image.asset('assets/Grocify.png', width: screenSize.width * 0.25),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsColumn() {
    return Column(
      children: [
        _buildStatCard(
          icon: Icons.shopping_bag,
          title: 'Total Products',
          value: context.watch<AdminProvider>().products.length.toString(),
        ),
        const SizedBox(height: 16),
        _buildStatCard(icon: Icons.category, title: 'Categories', value: '3'),
        const SizedBox(height: 16),
        _buildStatCard(icon: Icons.shopping_cart, title: 'Orders', value: '23'),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      height: 75,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),

      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green, size: 32),
              SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
