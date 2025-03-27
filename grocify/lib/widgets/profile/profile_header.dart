// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String userProfileImage;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.userProfileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ClipOval(
            child: SizedBox(
              height: 150,
              width: 150,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/Grocify_bg.png',
                image: userProfileImage,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
                placeholderFit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 500),
                fadeInCurve: Curves.easeIn,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            userName,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
