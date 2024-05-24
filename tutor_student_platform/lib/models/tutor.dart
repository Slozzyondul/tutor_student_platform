// models/tutor.dart
class Tutor {
  String id;
  String name;
  String email;
  String expertise;
  String availability;
  double rate;
  String qualifications;
  String mediaSampleUrl;

  Tutor({
    required this.id,
    required this.name,
    required this.email,
    required this.expertise,
    required this.availability,
    required this.rate,
    required this.qualifications,
    required this.mediaSampleUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'expertise': expertise,
      'availability': availability,
      'rate': rate,
      'qualifications': qualifications,
      'mediaSampleUrl': mediaSampleUrl,
    };
  }

  factory Tutor.fromMap(Map<String, dynamic> map) {
    return Tutor(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      expertise: map['expertise'],
      availability: map['availability'],
      rate: map['rate'],
      qualifications: map['qualifications'],
      mediaSampleUrl: map['mediaSampleUrl'],
    );
  }
}
