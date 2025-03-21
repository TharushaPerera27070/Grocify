import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onButtonPressed,
    required iconBackgroundColor,
    required IconData icon,
    required iconColor,
    Color backgroundColor = Colors.white,
    Color buttonColor = Colors.yellow,
    Color buttonTextColor = Colors.black,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Success Dialog",
      pageBuilder: (_, __, ___) => Container(), // This won't be used
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), // Start from bottom
            end: Offset.zero, // End at center
          ).animate(curvedAnimation),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: iconBackgroundColor,
                    radius: 40,
                    child: Icon(icon, color: iconColor, size: 50),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onButtonPressed,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: buttonTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
