import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocify/auth/sign_up.dart';
import 'package:grocify/firebase_options.dart';
import 'package:grocify/providers/navigation_provider.dart';
import 'package:grocify/providers/navigation_provider_admin.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProviderAdmin()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
