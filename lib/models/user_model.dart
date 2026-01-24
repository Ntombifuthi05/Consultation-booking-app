import 'dart:io';

class User {
  final String uid;
  final String studentId;
  final String name;
  final String email;
  final String phone;
  final String role;
  final File? image;  // Only changed this line from String? to File?

  User({
    required this.uid,
    required this.studentId,
    required this.name,
    required this.email,
    required this.phone,
    this.role = 'student',
    this.image,
  });

  factory User.fromMap(Map<String, dynamic> map, String uid) {
    return User(
      uid: uid,
      studentId: map['studentId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? 'student',
      image: map['image'] != null ? File(map['image']) : null,  // Added File conversion
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'image': image?.path,  // Changed to store path instead of File object
    };
  }

  User copyWith({
    String? name,
    String? phone,
    File? image,  // Changed parameter type
  }) {
    return User(
      uid: uid,
      studentId: studentId,
      name: name ?? this.name,
      email: email,
      phone: phone ?? this.phone,
      role: role,
      image: image ?? this.image,
    );
  }
  static bool validateStudentId(String id) {
    return RegExp(r'^[0-9]{9}$').hasMatch(id);
  }
}