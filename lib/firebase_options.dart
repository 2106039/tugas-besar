// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2drvebYNTm0eExYpBpgyXfEmA-bOVX1A',
    appId: '1:224414798750:android:f63407222c82faa4a77c8f',
    messagingSenderId: '224414798750',
    projectId: 'produk-kecantikan',
    storageBucket: 'produk-kecantikan.appspot.com',
  );


  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD1SY2e4PDU4t4CvhKcCNmCMDF4jjAkaTI',
    appId: '1:224414798750:web:da6bfcae30e61a00a77c8f',
    messagingSenderId: '224414798750',
    projectId: 'produk-kecantikan',
    authDomain: 'produk-kecantikan.firebaseapp.com',
    storageBucket: 'produk-kecantikan.appspot.com',
    measurementId: 'G-9RVYXJCMH5',
  );

}