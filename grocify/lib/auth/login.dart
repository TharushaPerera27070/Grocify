import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/Admin/admin_base.dart';
import 'package:grocify/auth/sign_up.dart';
import 'package:grocify/base.dart';
import 'package:grocify/services/auth_service.dart';
import 'package:grocify/widgets/auth/alert_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _showSuccessDialog(String role) {
    SuccessDialog.show(
      context: context,
      title: "Login Successfully!",
      message: "Welcome to Grocify!",
      buttonText: "Proceed",
      iconBackgroundColor: Colors.green,
      icon: Icons.check,
      iconColor: Colors.white,
      onButtonPressed: () {
        Navigator.of(context).pop();
        if (role == 'admin') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const AdminBase()),
          );
        } else {
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (ctx) => const Base()));
        }
      },
      buttonColor: const Color.fromARGB(255, 250, 200, 49),
    );
  }

  void _showErrorDialog() {
    SuccessDialog.show(
      context: context,
      title: "Login Unsuccessful!",
      message: "Please check your email and password.",
      buttonText: "Try Again",
      iconBackgroundColor: Colors.redAccent,
      icon: Icons.close,
      iconColor: Colors.black,
      onButtonPressed: () {
        Navigator.of(context).pop();
      },
      buttonColor: const Color.fromARGB(255, 250, 200, 49),
    );
  }

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Admin credentials (for example)
    const String adminEmail = 'admin@gmail.com';
    const String adminPassword = 'admin123';

    // Check if the entered credentials match admin credentials
    if (email == adminEmail && password == adminPassword) {
      _showSuccessDialog('admin');
    } else {
      // Normal user login using AuthService
      String loginResponse = await AuthService().login(
        email: email,
        password: password,
      );

      if (loginResponse == 'Login successful') {
        _showSuccessDialog('user');
      } else {
        _showErrorDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                      'Welcome back!',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Sign in to your account',
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
                            controller: _emailController,
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
                            controller: _passwordController,
                            obscureText: true,
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
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (value) {},
                              activeColor: Colors.green,
                            ),
                            Text(
                              "Remember me",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 28, 126, 207),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            "Login",
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
                          "Don't have an account?",
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
                                builder: (ctx) => const SignUp(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
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
