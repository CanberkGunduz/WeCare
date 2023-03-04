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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCVTS59WW0NllWykCdvrmKm7N0oabfqe0',
    appId: '1:694839190375:android:c8de929a52151f201cc5c2',
    messagingSenderId: '694839190375',
    projectId: 'gdscmetu2023',
    databaseURL: 'https://gdscmetu2023-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gdscmetu2023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBW93DpW2VyofTcjLF59HVFbNCdE8m27hc',
    appId: '1:694839190375:ios:eded1e53276d7e671cc5c2',
    messagingSenderId: '694839190375',
    projectId: 'gdscmetu2023',
    databaseURL: 'https://gdscmetu2023-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gdscmetu2023.appspot.com',
    iosClientId: '694839190375-3i6najsrriak5bvr7n8qsrjgqsdoh3p6.apps.googleusercontent.com',
    iosBundleId: 'com.example.gdscMetu2023',
  );
}
