// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grocify/providers/navigation_provider_admin.dart';
import 'package:provider/provider.dart';

class AdminBase extends StatefulWidget {
  const AdminBase({super.key});

  @override
  State<AdminBase> createState() => _AdminBaseState();
}

class _AdminBaseState extends State<AdminBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<NavigationProviderAdmin>().currentScreen,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: const Color.fromARGB(255, 255, 255, 255),
            tabBackgroundColor: Colors.green,
            padding: const EdgeInsets.all(12),
            gap: 8,
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                iconSize: 30,
                text: 'Home',
                textStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
              GButton(
                icon: Icons.list,
                iconSize: 30,
                text: 'Product List',
                textStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
              GButton(
                icon: Icons.person_outline,
                iconSize: 30,
                text: 'Admin Profile',
                textStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
            ],
            onTabChange: (index) {
              context.read<NavigationProviderAdmin>().updateIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
