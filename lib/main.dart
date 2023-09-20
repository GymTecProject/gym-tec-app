import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/app_router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:gym_tec/utils/image_utils.dart';
import 'color_schemes.g.dart';
import 'firebase_options.dart';

// TEST USERS
/*
ADMIN
  - email: amandadickerson@example.net
  - password: 123456
TRAINER
  - email: andersonroberta@example.org
  - password: 123456
USER
  - email: qjefferson@example.com
  - password: 123456
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // run emulator if debug mode is on
  // firebase emulators:start
  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
  ImageUtils.svgPrecacheImage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // initialize dependency manager

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.routes,
    );
  }
}
