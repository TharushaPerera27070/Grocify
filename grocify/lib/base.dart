import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grocify/providers/navigation_provider.dart';
import 'package:grocify/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  Future<void> _getUserInfo() async {
    if (context.read<UserProvider>().user == null) {
      await context.read<UserProvider>().getUserData();
      print(
        "Image URL ${context.read<UserProvider>().user!.profilePictureURL}",
      );
      print("Email ${context.read<UserProvider>().user!.email}");
      print("Name ${context.read<UserProvider>().user!.username}");
      print("Phone ${context.read<UserProvider>().user!.contactNumber}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<NavigationProvider>().currentScreen,
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
                icon: Icons.search,
                iconSize: 30,
                text: 'Search',
                textStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
              GButton(
                icon: Icons.favorite_border,
                iconSize: 30,
                text: 'Wishlist',
                textStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
              GButton(
                icon: Icons.shopping_cart_checkout,
                iconSize: 30,
                text: 'Cart',
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
                text: 'Profile',
                textStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
            ],
            onTabChange: (index) {
              context.read<NavigationProvider>().updateIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
