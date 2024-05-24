import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tutor.dart';
import 'tutor_profile_view_screen.dart'; // Add this import

class BrowseTutorsScreen extends StatelessWidget {
  Future<List<Tutor>> _getTutors() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('tutors').get();

    return querySnapshot.docs.map((doc) {
      return Tutor.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Browse Tutors')),
      body: FutureBuilder<List<Tutor>>(
        future: _getTutors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading tutors'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tutors found'));
          } else {
            List<Tutor> tutors = snapshot.data!;
            return ListView.builder(
              itemCount: tutors.length,
              itemBuilder: (context, index) {
                Tutor tutor = tutors[index];
                return ListTile(
                  title: Text(tutor.name),
                  subtitle: Text('Expertise: ${tutor.expertise}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TutorProfileViewScreen(userId: tutor.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
