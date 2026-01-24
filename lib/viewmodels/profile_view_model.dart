import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateProfile(String uid, String name, String phone) async {
    await _firestore.collection('users').doc(uid).update({
      'name': name,
      'phone': phone,
    });
  }
}