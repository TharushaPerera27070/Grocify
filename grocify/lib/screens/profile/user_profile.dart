import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/auth/login.dart';
import 'package:grocify/main.dart';
import 'package:grocify/providers/navigation_provider.dart';
import 'package:grocify/services/auth_service.dart';
import 'package:grocify/widgets/profile/password_section.dart';
import 'package:grocify/widgets/profile/personal_info_card.dart';
import 'package:grocify/widgets/profile/profile_header.dart';
import 'package:grocify/widgets/section_tile.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final String userName = "Kavya Sarameweera";
  final String userEmail = "Kota@Kalthara.com";
  final String userPhone = "+94 77 123 4567";
  final String userProfileImage =
      "assets/WhatsApp Image 2024-10-25 at 17.46.50_9440fb7e.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                userName: userName,
                userProfileImage: userProfileImage,
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(title: "Personal Information"),
                    PersonalInfoCard(
                      userPhone: userPhone,
                      userEmail: userEmail,
                    ),
                    const SizedBox(height: 24),
                    const SectionTitle(title: "Change Password"),
                    PasswordSection(),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 24),
                      child: ElevatedButton(
                        onPressed: () async {
                          await AuthService().logout();
                          context.read<NavigationProvider>().updateIndex(0);
                          print("Developed by WorkSync");
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const MyApp(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.red, width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Log Out",
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
