// models/student.dart
class Student {
  String id;
  String name;
  String email;
  String preferences;
  String searchCriteria;

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
