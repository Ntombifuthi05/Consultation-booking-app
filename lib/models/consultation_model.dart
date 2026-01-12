import 'package:cloud_firestore/cloud_firestore.dart';

class Consultation {
  final String id;
  final String lecturer;
  final String title;
  final String description;
  final DateTime date;
  final String userId;

  Consultation({
    required this.id,
    required this.lecturer,
    required this.title,
    required this.description,
    required this.date,
    required this.userId,
  });

  factory Consultation.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Consultation(
      id: doc.id,
      lecturer: data['lecturer'],
      title: data['title'],
      description: data['description'],
      date: (data['date'] as Timestamp).toDate(),
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'lecturer': lecturer,
      'title': title,
      'description': description,
      'date': date,
      'userId': userId,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}