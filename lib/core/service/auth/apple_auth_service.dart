import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// **Sign in with Apple**
  Future<UserCredential?> signInWithApple() async {
    try {
      // Apple Sign-In only works on iOS and macOS
      if (!Platform.isIOS && !Platform.isMacOS) {
        throw 'Apple Sign-In is only supported on iOS and macOS.';
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
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      throw 'An unexpected error occurred: $e';
    }
  }

  /// **Sign out from Apple**
  Future<void> signOutFromApple() async {
    await _auth.signOut();
  }

  /// **Handle Firebase Authentication Errors**
  String _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        return 'This email is already linked to another sign-in method.';
      case 'invalid-credential':
        return 'Invalid credentials received.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'operation-not-allowed':
        return 'Apple sign-in is not enabled for this Firebase project.';
      case 'network-request-failed':
        return 'Check your internet connection and try again.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
