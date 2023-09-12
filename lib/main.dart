import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/auth/auth.dart';
import 'package:gym_tec/auth/login.dart';
import 'package:gym_tec/auth/register.dart';
import 'package:gym_tec/pages/admin/admin_root_page.dart';
import 'package:gym_tec/pages/trainer/trainer_root_page.dart';
import 'package:gym_tec/pages/user/user_root_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFa2e200),
          onPrimary: Color.fromARGB(255, 0, 0, 0),
          secondary: Colors.purple,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Color(0xFF424242),
          onSurface: Colors.white,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthPage(),
        '/user': (context) => const UserRootPage(),
        '/admin': (context) => const AdminRootPage(),
        '/trainer': (context) => const TrainerRootPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
