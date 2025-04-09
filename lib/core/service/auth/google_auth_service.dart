import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/features/auth/modals/UserModal.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// **Sign in with Google & Store Data in Firestore**
  Future<UserCredential?> signInWithGoogle(
    BuildContext context,
    String userUid,
    String userLanguagePreference,
  ) async {
    try {
      // 🔍 Check if already signed in with Google
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final isGoogleUser = currentUser.providerData.any(
          (info) => info.providerId == 'google.com',
        );

        if (isGoogleUser) {
          print("Already signed in with Google");
          return null; // or return existing UserCredential if needed
        }
      }

      // Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Obtain authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _saveUserToFirestore(user, userUid, userLanguagePreference);
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(context, e);
    }
  }

  Future<void> _saveUserToFirestore(
    User user,
    String userUid,
    String userLanguagePreference,
  ) async {
    DocumentReference userDoc = _firestore.collection('users').doc(userUid);

    DocumentSnapshot docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      UserModel userModel = UserModel(
        uid: userUid, // Use the provided userUid
        name: user.displayName ?? "No Name",
        email: user.email ?? "No Email",
        userLanguagePreference: userLanguagePreference,
      );

      await userDoc.set(userModel.toJson());
    }
  }

  /// **Sign out from Google**
  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  /// **Handle Firebase Authentication Errors with Localization**
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
        return appLocalization.operationNotAllowed;
      case 'network-request-failed':
        return appLocalization.networkRequestFailed;
      default:
        return appLocalization.unexpectedError;
    }
  }
}
