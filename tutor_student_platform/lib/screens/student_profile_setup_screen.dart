import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student.dart';

class StudentProfileSetupScreen extends StatefulWidget {
  final String userId;

  const StudentProfileSetupScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  _StudentProfileSetupScreenState createState() =>
      _StudentProfileSetupScreenState();
}

class _StudentProfileSetupScreenState extends State<StudentProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, preferences, searchCriteria;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Preferences'),
                onSaved: (value) => preferences = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Search Criteria'),
                onSaved: (value) => searchCriteria = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Student student = Student(
        id: widget.userId,
        name: name,
        email: email,
        preferences: preferences,
        searchCriteria: searchCriteria,
      );

      try {
        await FirebaseFirestore.instance
            .collection('students')
            .doc(widget.userId)
            .set(student.toMap());

        // Optionally, navigate to another screen or show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile saved successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving profile: $e')),
        );
      }
    }
  }
}

// models/student.dart
class Student {
  final String id;
  final String name;
  final String email;
  final String preferences;
  final String searchCriteria;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.preferences,
    required this.searchCriteria,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'preferences': preferences,
      'searchCriteria': searchCriteria,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      preferences: map['preferences'],
      searchCriteria: map['searchCriteria'],
    );
  }
}
