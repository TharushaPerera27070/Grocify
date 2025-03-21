import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:grocify/auth/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocify',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/Grocify.png'),
        duration: 2100,
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: const SignUp(),
      ),
    );
  }
}
