import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tutor.dart';

class TutorProfileViewScreen extends StatelessWidget {
  final String userId;

  const TutorProfileViewScreen({Key? key, required this.userId})
      : super(key: key);

  Future<Tutor?> _getTutorProfile() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('tutors').doc(userId).get();

    if (doc.exists) {
      return Tutor.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: FutureBuilder<Tutor?>(
        future: _getTutorProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading profile'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Profile not found'));
          } else {
            Tutor tutor = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text('Name: ${tutor.name}', style: TextStyle(fontSize: 18)),
                  Text('Email: ${tutor.email}', style: TextStyle(fontSize: 18)),
                  Text('Expertise: ${tutor.expertise}',
                      style: TextStyle(fontSize: 18)),
                  Text('Availability: ${tutor.availability}',
                      style: TextStyle(fontSize: 18)),
                  Text('Rate: \$${tutor.rate}', style: TextStyle(fontSize: 18)),
                  Text('Qualifications: ${tutor.qualifications}',
                      style: TextStyle(fontSize: 18)),
                  if (tutor.mediaSampleUrl.isNotEmpty)
                    Column(
                      children: [
                        SizedBox(height: 10),
                        Image.network(tutor.mediaSampleUrl),
                      ],
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
