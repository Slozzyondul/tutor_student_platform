// tutor_profile_setup_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tutor.dart';

class TutorProfileSetupScreen extends StatefulWidget {
  final String userId;

  const TutorProfileSetupScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  _TutorProfileSetupScreenState createState() =>
      _TutorProfileSetupScreenState();
}

class _TutorProfileSetupScreenState extends State<TutorProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name,
      email,
      expertise,
      availability,
      qualifications,
      mediaSampleUrl;
  late double rate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tutor Profile Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Expertise'),
                onSaved: (value) => expertise = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Availability'),
                onSaved: (value) => availability = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rate'),
                keyboardType: TextInputType.number,
                onSaved: (value) => rate = double.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Qualifications'),
                onSaved: (value) => qualifications = value!,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Media Sample URL'),
                onSaved: (value) => mediaSampleUrl = value!,
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
      Tutor tutor = Tutor(
        id: widget.userId,
        name: name,
        email: email,
        expertise: expertise,
        availability: availability,
        rate: rate,
        qualifications: qualifications,
        mediaSampleUrl: mediaSampleUrl,
      );

      await FirebaseFirestore.instance
          .collection('tutors')
          .doc(widget.userId)
          .set(tutor.toMap());

      // Navigate to the next screen or show a success message
    }
  }
}
