import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskapp/core/service/auth/google_auth_service.dart';

part 'google_auth_event.dart';

part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  final GoogleAuthService _googleAuthService;

  GoogleAuthBloc(this._googleAuthService) : super(GoogleAuthInitial()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<GoogleAuthSignOutEvent>(_onSignOutFromGoogle);
  }

  // sign in with google
  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<GoogleAuthState> emit,
  ) async {
    emit(GoogleAuthLoading());
    try {
      final UserCredential? userCredential = await _googleAuthService
          .signInWithGoogle(
            event.context,
            event.userUid,
            event.userLanguagePreference,
          );
      if (userCredential != null && userCredential.user != null) {
        emit(GoogleAuthSuccess(userCredential.user!));
      } else {
        emit(GoogleAuthFailure("Google sign-in failed."));
      }
    } catch (e) {
      emit(GoogleAuthFailure(e.toString()));
    }
  }

  // sign out from google
  Future<void> _onSignOutFromGoogle(
    GoogleAuthSignOutEvent event,
    Emitter<GoogleAuthState> emit,
  ) async {
    emit(GoogleAuthLoading());
    try {
      await _googleAuthService.signOutFromGoogle();
      emit(GoogleAuthSignOutSuccess()); // Updated state
    } catch (e) {
      emit(GoogleAuthFailure(e.toString()));
    }
  }
}
