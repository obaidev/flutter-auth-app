import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth_app/services/secure_storage.dart';
import '../controllers/user_controller.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login(String email, String password) async {
    log('Login attempt for email: $email');

    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) {
        log('Login failed: user not found');
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'User not found',
        );
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();
      final data = doc.data() ?? {};
      final role = data['role'] ?? 'user';
      final name = data['name'] ?? '';

      final token = await user.getIdToken();
      await storage.save(token!, role);

      userController.setUser(role, name);

      log('Login successful: UID=${user.uid}, role=$role, name=$name');
    } catch (e) {
      log('Login error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    log('Logging out user');

    try {
      await _auth.signOut();
      await storage.clear();
      userController.clear();

      log('Logout successful');
    } catch (e) {
      log('Logout error: $e');
      rethrow;
    }
  }
}

final authRepo = AuthRepository();
