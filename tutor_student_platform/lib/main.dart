import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/tutor_profile_setup_screen.dart';
import 'screens/student_profile_setup_screen.dart';
import 'screens/tutor_profile_view_screen.dart';
import 'screens/browse_tutors_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAMvJdd0aNS8RO5ViMNocnzmngPmFxvWCA",
      authDomain: "tutor-student-platform.firebaseapp.com",
      projectId: "tutor-student-platform",
      storageBucket: "tutor-student-platform.appspot.com",
      messagingSenderId: "152102935057",
      appId: "1:152102935057:web:0bc86f8c6059d96e5eafb0",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutor Student Platform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/tutorProfileSetup': (context) => TutorProfileSetupScreen(
            userId: ModalRoute.of(context)!.settings.arguments as String),
        '/studentProfileSetup': (context) => StudentProfileSetupScreen(
            userId: ModalRoute.of(context)!.settings.arguments as String),
        '/tutorProfileView': (context) => TutorProfileViewScreen(
            userId: ModalRoute.of(context)!.settings.arguments as String),
        '/browseTutors': (context) => BrowseTutorsScreen(),
      },
    );
  }
}
