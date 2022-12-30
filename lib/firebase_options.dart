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
    apiKey: 'AIzaSyD9BkJifV4iVfsL-FNx3kdfdkRHQr_2YTA',
    appId: '1:505789696745:web:1b9a339b28925294733e78',
    messagingSenderId: '505789696745',
    projectId: 'chat-app-87907',
    authDomain: 'chat-app-87907.firebaseapp.com',
    storageBucket: 'chat-app-87907.appspot.com',
    measurementId: 'G-CRPTV04BPW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCg8HH4kDPvirdNn5Ixn_qd8JbKDzdvCE',
    appId: '1:505789696745:android:f9fbddd1bc7ff6f9733e78',
    messagingSenderId: '505789696745',
    projectId: 'chat-app-87907',
    storageBucket: 'chat-app-87907.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDF0dbFu99lDhecI9KAQugZNY0SDEfZpCs',
    appId: '1:505789696745:ios:389282e2bbfd27a3733e78',
    messagingSenderId: '505789696745',
    projectId: 'chat-app-87907',
    storageBucket: 'chat-app-87907.appspot.com',
    iosClientId: '505789696745-3tks6it5v3gb7oc40eidqpgu60o1dsl0.apps.googleusercontent.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDF0dbFu99lDhecI9KAQugZNY0SDEfZpCs',
    appId: '1:505789696745:ios:389282e2bbfd27a3733e78',
    messagingSenderId: '505789696745',
    projectId: 'chat-app-87907',
    storageBucket: 'chat-app-87907.appspot.com',
    iosClientId: '505789696745-3tks6it5v3gb7oc40eidqpgu60o1dsl0.apps.googleusercontent.com',
    iosBundleId: 'com.example.chat',
  );
}
