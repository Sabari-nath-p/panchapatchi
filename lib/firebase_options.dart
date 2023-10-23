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
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAHd4cKLr5rB0FMHXfUYqvETiKKlgDgKyU',
    appId: '1:652862274449:web:6728a275d0a2f3c873b830',
    messagingSenderId: '652862274449',
    projectId: 'panchapatchi-calculator',
    authDomain: 'panchapatchi-calculator.firebaseapp.com',
    databaseURL: 'https://panchapatchi-calculator-default-rtdb.firebaseio.com',
    storageBucket: 'panchapatchi-calculator.appspot.com',
    measurementId: 'G-DGWBX83ZQ8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbz8Fu4arsFBriQ2BntFXHzdwm7NrYjYE',
    appId: '1:652862274449:android:4c7d49967b078db673b830',
    messagingSenderId: '652862274449',
    projectId: 'panchapatchi-calculator',
    databaseURL: 'https://panchapatchi-calculator-default-rtdb.firebaseio.com',
    storageBucket: 'panchapatchi-calculator.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6SsLFYEeh15iVGp66OMrJ9u7UxlaxE2k',
    appId: '1:652862274449:ios:4a6608364f4fe65373b830',
    messagingSenderId: '652862274449',
    projectId: 'panchapatchi-calculator',
    databaseURL: 'https://panchapatchi-calculator-default-rtdb.firebaseio.com',
    storageBucket: 'panchapatchi-calculator.appspot.com',
    iosClientId: '652862274449-qnmb7kqlmm1ogdfbob56nbght7a5cddn.apps.googleusercontent.com',
    iosBundleId: 'com.example.panthapatchi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6SsLFYEeh15iVGp66OMrJ9u7UxlaxE2k',
    appId: '1:652862274449:ios:6bc721157f1a383f73b830',
    messagingSenderId: '652862274449',
    projectId: 'panchapatchi-calculator',
    databaseURL: 'https://panchapatchi-calculator-default-rtdb.firebaseio.com',
    storageBucket: 'panchapatchi-calculator.appspot.com',
    iosBundleId: 'com.example.panthapatchi.RunnerTests',
  );
}