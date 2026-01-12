import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/user_model.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get user {
    return _auth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      final doc = await _firestore.collection('users').doc(firebaseUser.uid).get();
      return doc.exists ? User.fromMap(doc.data()!, firebaseUser.uid) : null;
    });
  }

Future<User?> getCurrentUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;
    
    final doc = await _firestore.collection('users').doc(firebaseUser.uid).get();
    return doc.exists ? User.fromMap(doc.data()!, firebaseUser.uid) : null;
  }
  
  Future<User?> login(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final doc = await _firestore.collection('users').doc(cred.user!.uid).get();
      return doc.exists ? User.fromMap(doc.data()!, cred.user!.uid) : null;
    } catch (e) {
      return null;
    }
  }

  Future<User?> register({
    required String email,
    required String password,
    required String studentId,
    required String name,
    required String phone,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = User(
        uid: cred.user!.uid,
        studentId: studentId,
        name: name,
        email: email,
        phone: phone,
      );

      await _firestore.collection('users').doc(user.uid).set(user.toMap());
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> updateUserData(User user) async {
    await _firestore.collection('users').doc(user.uid).update(user.toMap());
  }
}