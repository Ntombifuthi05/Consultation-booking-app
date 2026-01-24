import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/user_model.dart' as model;
import 'package:flutter/material.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get current user document
  Future<model.User> getCurrentUser() async {
    final currentUser = auth.FirebaseAuth.instance.currentUser;
    if (currentUser == null) throw Exception('No authenticated user');

    final doc = await _firestore.collection('users').doc(currentUser.uid).get();
    if (!doc.exists) throw Exception('User document not found');

    return model.User.fromMap(doc.data()!, currentUser.uid);
  }

  // Update user profile (including image handling)
  Future<void> updateUserProfile({
    required String uid,
    required String name,
    required String phone,
    File? imageFile, // New parameter for image file
    String? existingImageUrl, // For cases where we keep existing image
  }) async {
    String? imageUrl = existingImageUrl;

    // Upload new image if provided
    if (imageFile != null) {
      try {
        // Delete old image if exists
        if (existingImageUrl != null) {
          await _deleteImageFromUrl(existingImageUrl);
        }

        // Upload new image
        imageUrl = await _uploadProfileImage(imageFile, uid);
      } catch (e) {
        print('Error updating profile image: $e');
        // Continue with profile update even if image fails
      }
    }

    // Update user data in Firestore
    await _firestore.collection('users').doc(uid).update({
      'name': name,
      'phone': phone,
      'image': imageUrl, // Stores the URL/path string
    });
  }

  // Upload image to Firebase Storage
  Future<String> _uploadProfileImage(File imageFile, String userId) async {
    try {
      final ref = _storage
          .ref()
          .child('profile_images')
          .child('$userId-${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading profile image: $e');
      throw Exception('Failed to upload profile image');
    }
  }

  // Delete image from Firebase Storage
  Future<void> _deleteImageFromUrl(String imageUrl) async {
    try {
      final ref = _storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      print('Error deleting old profile image: $e');
    }
  }

  // Get user by ID
  Future<model.User> getUserById(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) throw Exception('User not found');
    return model.User.fromMap(doc.data()!, uid);
  }

  // Additional methods (keep existing functionality)
  Future<void> updateUserRole(String uid, String newRole) async {
    await _firestore.collection('users').doc(uid).update({'role': newRole});
  }
  
Stream<QuerySnapshot> getAllBookings({
    String searchQuery = '',
    DateTimeRange? dateRange,
  }) {
    Query query = _firestore.collection('bookings').orderBy('date', descending: true);

    if (searchQuery.isNotEmpty) {
      query = query.where('studentId', isGreaterThanOrEqualTo: searchQuery)
                  .where('studentId', isLessThan: searchQuery + 'z');
    }

    if (dateRange != null) {
      query = query.where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(dateRange.start))
                  .where('date', isLessThanOrEqualTo: Timestamp.fromDate(dateRange.end));
    }

    return query.snapshots();
  }

  Future<void> deleteBooking(String bookingId) async {
    await _firestore.collection('bookings').doc(bookingId).delete();
  }
  // ... (keep other existing methods unchanged)
}