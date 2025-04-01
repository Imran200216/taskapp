import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/features/auth/modals/UserModal.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class EmailPasswordAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// **Create User with Email & Password**
  Future<UserCredential?> createPassword({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String userLanguagePreference,
    required String userUid,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user model
      UserModel user = UserModel(
        uid: userUid,
        name: name,
        email: email,
        userLanguagePreference: userLanguagePreference,
      );

      // Save to Firestore
      await _firestore.collection('users').doc(userUid).set(user.toJson());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(context, e);
    }
  }

  /// **Sign In with Email & Password**
  Future<UserCredential?> signInWithPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(context, e);
    }
  }

  /// **Send Password Reset Email**
  Future<void> sendPasswordResetEmail({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(context, e);
    }
  }

  /// **Sign Out**
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("User signed out successfully");
    } catch (e) {
      print("Error signing out: $e");
      throw Exception("Failed to sign out. Please try again.");
    }
  }

  /// **Handle Firebase Authentication Errors**
  String _handleFirebaseAuthError(BuildContext context, FirebaseAuthException e) {
    final appLocalization = AppLocalizations.of(context);

    switch (e.code) {
      case 'email-already-in-use':
        return appLocalization.emailAlreadyInUse;
      case 'invalid-email':
        return appLocalization.invalidEmail;
      case 'operation-not-allowed':
        return appLocalization.operationNotAllowed;
      case 'weak-password':
        return appLocalization.weakPassword;
      case 'user-disabled':
        return appLocalization.userDisabled;
      case 'user-not-found':
        return appLocalization.userNotFound;
      case 'wrong-password':
        return appLocalization.wrongPassword;
      case 'too-many-requests':
        return appLocalization.tooManyRequests;
      default:
        return appLocalization.unexpectedError;
    }
  }
}
