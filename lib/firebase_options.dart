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
    apiKey: 'AIzaSyB2XaLqZPs-bbKs3CFv5divAZypMojvGY0',
    appId: '1:1006287327456:web:0adef7d4a1e00d3fe94085',
    messagingSenderId: '1006287327456',
    projectId: 'barfitapp',
    authDomain: 'barfitapp.firebaseapp.com',
    storageBucket: 'barfitapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPwiNfY2HQsbgVt8JZbRjAbZpRsn27hXM',
    appId: '1:1006287327456:android:74fa529113505928e94085',
    messagingSenderId: '1006287327456',
    projectId: 'barfitapp',
    storageBucket: 'barfitapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBr0uSyJINXseVMSMiUFPhy8gZJ8EuEI50',
    appId: '1:1006287327456:ios:0d7f0c88fbba17a1e94085',
    messagingSenderId: '1006287327456',
    projectId: 'barfitapp',
    storageBucket: 'barfitapp.appspot.com',
    iosClientId: '1006287327456-0cd3f357ebghhektcnbel18acnljjp6i.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterDemoBt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBr0uSyJINXseVMSMiUFPhy8gZJ8EuEI50',
    appId: '1:1006287327456:ios:d34f9fc0fa54f959e94085',
    messagingSenderId: '1006287327456',
    projectId: 'barfitapp',
    storageBucket: 'barfitapp.appspot.com',
    iosClientId: '1006287327456-48scmgj5km56epmcabnmam7s08bsius7.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterDemo.RunnerTests',
  );
}
