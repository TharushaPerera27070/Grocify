import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Signup function
  Future<String> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Create a new user with email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Update display name after successful account creation
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      return 'Account created successfully';
    } on FirebaseAuthException catch (e) {
      // Handle different FirebaseAuthException error codes
      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'Error: ${e.message}';
      }
      return errorMessage;
    } catch (e) {
      // Catch any other errors and log them
      print("Error occurred: $e");
      return 'An unexpected error occurred. Please try again.';
    }
  }

  // Login function
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Login successful';
    } on FirebaseAuthException catch (e) {
      // Handle different FirebaseAuthException error codes
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = 'Error: ${e.message}';
      }
      return errorMessage;
    } catch (e) {
      // Catch any other errors and log them
      print("Error occurred: $e");
      return 'An unexpected error occurred. Please try again.';
    }
  }

  // Logout function
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
