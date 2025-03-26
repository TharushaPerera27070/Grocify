// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDMtGqdc0YvLPQTqzyloc26Tyubel9kB_I',
    appId: '1:599644042741:web:b211b446d3b1305b071cbc',
    messagingSenderId: '599644042741',
    projectId: 'grocify-a0baf',
    authDomain: 'grocify-a0baf.firebaseapp.com',
    storageBucket: 'grocify-a0baf.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlQVPmSXffa6vevNxIYY7n68VH7dpNad0',
    appId: '1:599644042741:android:4d599485af540a84071cbc',
    messagingSenderId: '599644042741',
    projectId: 'grocify-a0baf',
    storageBucket: 'grocify-a0baf.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiJdY1NgQwR4QixQ9C7nBrJwT0OW8Jfyw',
    appId: '1:599644042741:ios:1777de1d5b169285071cbc',
    messagingSenderId: '599644042741',
    projectId: 'grocify-a0baf',
    storageBucket: 'grocify-a0baf.firebasestorage.app',
    iosBundleId: 'com.example.grocify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDiJdY1NgQwR4QixQ9C7nBrJwT0OW8Jfyw',
    appId: '1:599644042741:ios:1777de1d5b169285071cbc',
    messagingSenderId: '599644042741',
    projectId: 'grocify-a0baf',
    storageBucket: 'grocify-a0baf.firebasestorage.app',
    iosBundleId: 'com.example.grocify',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDMtGqdc0YvLPQTqzyloc26Tyubel9kB_I',
    appId: '1:599644042741:web:8c39a30e8eb34bbb071cbc',
    messagingSenderId: '599644042741',
    projectId: 'grocify-a0baf',
    authDomain: 'grocify-a0baf.firebaseapp.com',
    storageBucket: 'grocify-a0baf.firebasestorage.app',
  );
}
