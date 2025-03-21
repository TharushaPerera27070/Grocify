import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/auth/login.dart';
import 'package:grocify/widgets/auth/alert_dialog.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  void _showSuccessDialog() {
    SuccessDialog.show(
      context: context,
      title: "Account Created Successfully!",
      message: "Your account has been created successfully.",
      buttonText: "Login",
      iconBackgroundColor: Colors.green,
      icon: Icons.check,
      iconColor: Colors.white,
      onButtonPressed: () {
        Navigator.of(context).pop();
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (ctx) => const Login()));
      },
      buttonColor: const Color.fromARGB(255, 250, 200, 49),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.07),
            Image.asset('assets/Grocify.png'),
            const SizedBox(height: 20),
            Image.asset(
              "assets/Online Groceries-cuate 1.png",
              height: screenSize.height * 0.3,
            ),
            SizedBox(height: 32),
            Container(
              height: screenSize.height,
              width: double.infinity,
              color: const Color.fromARGB(255, 220, 217, 217),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create an Account',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Quickly create an account',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              prefixIcon: const Icon(Icons.mail_outlined),
                              labelText: "Email address",
                              labelStyle: GoogleFonts.poppins(
                                color: Colors.grey[500],
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              fillColor: Colors.white,
                              filled: true,

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              prefixIcon: const Icon(Icons.person_outline),
                              labelText: "Full Name",
                              labelStyle: GoogleFonts.poppins(
                                color: Colors.grey[500],
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              fillColor: Colors.white,
                              filled: true,

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              prefixIcon: const Icon(Icons.lock_outlined),
                              labelText: "Password",
                              labelStyle: GoogleFonts.poppins(
                                color: Colors.grey[500],
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              fillColor: Colors.white,
                              filled: true,

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showSuccessDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 60, 63, 66),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const Login(),
                              ),
                            );
                          },
                          child: Text(
                            "LOGIN",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
