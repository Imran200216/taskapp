import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskapp/core/service/auth/apple_auth_service.dart';

part 'apple_auth_event.dart';

part 'apple_auth_state.dart';

class AppleAuthBloc extends Bloc<AppleAuthEvent, AppleAuthState> {
  final AppleAuthService _appleAuthService;

  AppleAuthBloc(this._appleAuthService) : super(AppleAuthInitial()) {
    on<AppleSignInRequested>(_onAppleSignInRequested);
    on<AppleSignOutRequested>(_onAppleSignOutRequested);
  }

  Future<void> _onAppleSignInRequested(
    AppleSignInRequested event,
    Emitter<AppleAuthState> emit,
  ) async {
    emit(AppleAuthLoading());
    try {
      final UserCredential? userCredential =
          await _appleAuthService.signInWithApple();
      if (userCredential != null) {
        emit(AppleAuthSuccess(userCredential.user!));
      } else {
        emit(const AppleAuthFailure("Apple Sign-In failed"));
      }
    } catch (e) {
      emit(AppleAuthFailure(e.toString()));
    }
  }

  Future<void> _onAppleSignOutRequested(
    AppleSignOutRequested event,
    Emitter<AppleAuthState> emit,
  ) async {
    emit(AppleAuthLoading());
    try {
      await _appleAuthService.signOutFromApple();
      emit(AppleAuthSignedOut());
    } catch (e) {
      emit(AppleAuthFailure(e.toString()));
    }
  }
}
