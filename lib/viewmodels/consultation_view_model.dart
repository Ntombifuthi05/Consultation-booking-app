import 'package:consultation/models/consultation_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultationViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addConsultation(Consultation consultation, String userId) async {
    await _firestore.collection('consultations').add(consultation.toFirestore());
  }

  Stream<List<Consultation>> getUserConsultations(String userId) {
    return _firestore
        .collection('consultations')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Consultation.fromFirestore(doc))
            .toList());
  }

  Future<void> deleteConsultation(String id) async {
    await _firestore.collection('consultations').doc(id).delete();
  }


  Future<void> updateConsultation(Consultation consultation) async {
    await _firestore
        .collection('consultations')
        .doc(consultation.id)
        .update(consultation.toFirestore());
  }
}