import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/l10n/app_localizations.dart';
import 'package:taskapp/features/auth/modals/UserModal.dart';

class AppleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// **Sign in with Apple**
  Future<UserCredential?> signInWithApple({
    required BuildContext context,
    required String userUid, // Pass user UID
    required String userLanguagePreference, // Pass user's language preference
  }) async {
    try {
      final appLocalization = AppLocalizations.of(context);

      // Apple Sign-In only works on iOS and macOS
      if (!Platform.isIOS && !Platform.isMacOS) {
        throw appLocalization.appleSignInNotSupported;
      }

      // Request Apple credentials
      final AuthorizationCredentialAppleID appleCredential =
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create Firebase OAuth credential
      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase with Apple credentials
      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      // Get user details
      User? user = userCredential.user;
      if (user != null) {
        await _saveUserToFirestore(userUid, user, userLanguagePreference);
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(context, e);
    } catch (e) {
      throw '${AppLocalizations.of(context).unexpectedError}: $e';
    }
  }

  /// **Save User to Firestore**
  Future<void> _saveUserToFirestore(
      String userUid, User user, String userLanguagePreference) async {
    // Create user model
    UserModel userModel = UserModel(
      uid: userUid, // Use passed UID instead of Firebase-generated UID
      name: user.displayName ?? "Unknown",
      email: user.email ?? "",
      userLanguagePreference: userLanguagePreference,
    );

    // Save to Firestore under `users` collection using userUid
    await _firestore
        .collection('users')
        .doc(userUid)
        .set(userModel.toJson(), SetOptions(merge: true));
  }

  /// **Sign out from Apple**
  Future<void> signOutFromApple() async {
    await _auth.signOut();
  }

  /// **Handle Firebase Authentication Errors**
  String _handleFirebaseAuthError(BuildContext context, FirebaseAuthException e) {
    final appLocalization = AppLocalizations.of(context);

    switch (e.code) {
      case 'account-exists-with-different-credential':
        return appLocalization.accountExistsWithDifferentCredential;
      case 'invalid-credential':
        return appLocalization.invalidCredential;
      case 'user-disabled':
        return appLocalization.userDisabled;
      case 'operation-not-allowed':
        return appLocalization.appleSignInNotEnabled;
      case 'network-request-failed':
        return appLocalization.networkError;
      default:
        return appLocalization.unexpectedError;
    }
  }
}
