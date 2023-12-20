import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:user_repository/user_repository.dart';

import 'app.dart';
import 'simple_bloc_observer.dart';

void main() async {
  // Ensure that the Flutter app is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase. 
  // This is required before using Firebase services.
  await Firebase.initializeApp();

  // Initialize time zones for use in the app.
  tz.initializeTimeZones();

  // Set a custom observer for the BLoC state changes.
  // SimpleBlocObserver is a custom class that tracks BLoC state changes. 
  Bloc.observer = SimpleBlocObserver();

  // Set the preferred orientation of the device to portrait (vertical).
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Run the Flutter app, passing the FirebaseUserRepository to the MyApp widget.
  runApp(MyApp(FirebaseUserRepository()));
}