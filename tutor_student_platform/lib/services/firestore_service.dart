import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(String uid, String role) async {
    await _db.collection('users').doc(uid).set({
      'role': role,
    });
  }

  Future<String?> getUserRole(String uid) async {
    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    return (doc.data() as Map<String, dynamic>?)?['role'];
  }
}
