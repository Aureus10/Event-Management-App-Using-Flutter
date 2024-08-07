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
    apiKey: 'AIzaSyB6iQiV2ytwqT1HMpEVQsvXecprpd_Jr-U',
    appId: '1:132450195525:web:7a64cac5894cbb58bb6b2c',
    messagingSenderId: '132450195525',
    projectId: 'mae-assignment-a88ea',
    authDomain: 'mae-assignment-a88ea.firebaseapp.com',
    storageBucket: 'mae-assignment-a88ea.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1F3UyRFsOOsHWA0Lmu-TK7Gwt9v7rHR4',
    appId: '1:411542835831:android:b515fcd2e92c219c0aac72',
    messagingSenderId: '411542835831',
    projectId: 'mae-assignment-f43cb',
    databaseURL: 'https://mae-assignment-f43cb-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'mae-assignment-f43cb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVjRHSwhIaH6-At6yX8wGoAK0GBPs5Ato',
    appId: '1:132450195525:ios:9e9cbcf80a145367bb6b2c',
    messagingSenderId: '132450195525',
    projectId: 'mae-assignment-a88ea',
    storageBucket: 'mae-assignment-a88ea.appspot.com',
    iosBundleId: 'com.example.assignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDVjRHSwhIaH6-At6yX8wGoAK0GBPs5Ato',
    appId: '1:132450195525:ios:9e9cbcf80a145367bb6b2c',
    messagingSenderId: '132450195525',
    projectId: 'mae-assignment-a88ea',
    storageBucket: 'mae-assignment-a88ea.appspot.com',
    iosBundleId: 'com.example.assignment',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB6iQiV2ytwqT1HMpEVQsvXecprpd_Jr-U',
    appId: '1:132450195525:web:acb816dcba97395fbb6b2c',
    messagingSenderId: '132450195525',
    projectId: 'mae-assignment-a88ea',
    authDomain: 'mae-assignment-a88ea.firebaseapp.com',
    storageBucket: 'mae-assignment-a88ea.appspot.com',
  );

}