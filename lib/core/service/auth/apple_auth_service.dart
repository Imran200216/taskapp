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
    required String userUid, // Passed UID
    required String userLanguagePreference, // Passed language preference
  }) async {
    try {
      final appLocalization = AppLocalizations.of(context);

      // Ensure Apple Sign-In is supported on the platform
      if (!Platform.isIOS && !Platform.isMacOS) {
        throw appLocalization.appleSignInNotSupported;
      }

      print("🟡 Requesting Apple Sign-In...");

      // Request Apple credentials
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );

      print("🟢 Apple Credential received!");

      // Create Firebase OAuth credential
      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      print("✅ Firebase Sign-In Successful!");

      // Get user details
      User? user = userCredential.user;
      if (user != null) {
        print("📄 Saving user to Firestore...");
        await _saveUserToFirestore(userUid, user, userLanguagePreference);
        print("✅ User saved successfully!");
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("❌ Firebase Auth Error: ${e.message}");
      throw _handleFirebaseAuthError(context, e);
    } catch (e) {
      print("❌ Unexpected Error: $e");
      throw '${AppLocalizations.of(context).unexpectedError}: $e';
    }
  }

  /// **Save User to Firestore**
  Future<void> _saveUserToFirestore(
    String userUid,
    User user,
    String userLanguagePreference,
  ) async {
    // Use Firebase UID if userUid is empty
    String finalUid = userUid.isNotEmpty ? userUid : user.uid;

    // Create user model
    UserModel userModel = UserModel(
      uid: finalUid,
      name: user.displayName ?? "Unknown",
      email: user.email ?? "",
      userLanguagePreference: userLanguagePreference,
    );

    // Save to Firestore
    await _firestore
        .collection('users')
        .doc(finalUid)
        .set(userModel.toJson(), SetOptions(merge: true));
  }

  /// **Sign out from Apple**
  Future<void> signOutFromApple() async {
    await _auth.signOut();
  }

  /// **Handle Firebase Authentication Errors**
  String _handleFirebaseAuthError(
    BuildContext context,
    FirebaseAuthException e,
  ) {
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
