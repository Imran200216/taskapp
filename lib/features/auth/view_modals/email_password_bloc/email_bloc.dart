import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/core/service/auth/email_password_auth_service.dart';

part 'email_event.dart';

part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final EmailPasswordAuthService _authService;

  EmailBloc(this._authService) : super(EmailInitial()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  /// Email password sign-up bloc
  Future<void> _onSignUp(SignUpEvent event, Emitter<EmailState> emit) async {
    emit(EmailPasswordAuthLoading());
    try {
      await _authService.createPassword(
        email: event.email,
        password: event.password,
        name: event.name,
        userLanguagePreference: event.userLanguagePreference,
        userUid: event.userUid,
        context: event.context,
      );
      emit(EmailPasswordAuthSuccess("Account created successfully!"));
    } catch (e) {
      emit(EmailPasswordAuthFailure(e.toString()));
    }
  }

  /// Email password sign-in bloc
  Future<void> _onSignIn(SignInEvent event, Emitter<EmailState> emit) async {
    emit(EmailPasswordAuthLoading());
    try {
      await _authService.signInWithPassword(
        email: event.email,
        password: event.password,
        context: event.context,
      );
      emit(EmailPasswordAuthSuccess("Login successful!"));
    } catch (e) {
      emit(EmailPasswordAuthFailure(e.toString()));
    }
  }

  /// Reset password bloc
  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<EmailState> emit,
  ) async {
    emit(EmailPasswordAuthLoading());
    try {
      await _authService.sendPasswordResetEmail(
        email: event.email,
        context: event.context,
      );
      emit(EmailPasswordAuthSuccess("Password reset email sent!"));
    } catch (e) {
      emit(EmailPasswordAuthFailure(e.toString()));
    }
  }
}
