import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'tutor_profile_setup_screen.dart';
import 'student_profile_setup_screen.dart';
import 'tutor_profile_view_screen.dart';
import 'browse_tutors_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigate to the appropriate profile setup screen based on user type
      String userId = userCredential.user!.uid;
      bool isNewUser = userCredential.additionalUserInfo!.isNewUser;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => isNewUser
              ? TutorProfileSetupScreen(userId: userId)
              : TutorProfileViewScreen(userId: userId),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific exceptions
      if (e.code == 'user-not-found') {
        _showError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _showError('Wrong password provided for that user.');
      } else {
        _showError(e.message!);
      }
    } catch (e) {
      // Handle other exceptions
      _showError('An error occurred. Please try again.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrowseTutorsScreen(),
                  ),
                );
              },
              child: Text('Browse Tutors'),
            ),
          ],
        ),
      ),
    );
  }
}
