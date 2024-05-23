import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAMvJdd0aNS8RO5ViMNocnzmngPmFxvWCA',
        appId: '1:152102935057:web:0bc86f8c6059d96e5eafb0',
        messagingSenderId: '152102935057',
        projectId: 'tutor-student-platform',
        authDomain: 'tutor-student-platform.firebaseapp.com',
        storageBucket: 'tutor-student-platform.appspot.com',
        databaseURL: 'https://tutor-student-platform.firebaseio.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutor Student Platform',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: LoginScreen(),
    );
  }
}
