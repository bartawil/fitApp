// import 'package:flutter/material.dart';
// import 'package:flutter_demo/data_uploader_screen.dart';
// import 'package:flutter_demo/pages/auth_page.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_demo/screens/splash/splash_screen.dart';
// import 'firebase_options.dart';
// import 'package:get/get.dart';

// void main(){
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: SplashScreen());
//   }
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(GetMaterialApp(home: DataUploaderScreen()));
// }

import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}