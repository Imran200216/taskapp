part of 'apple_auth_bloc.dart';

sealed class AppleAuthEvent extends Equatable {
  const AppleAuthEvent();
  @override
  List<Object?> get props => [];
}

class AppleSignInRequested extends AppleAuthEvent {}

class AppleSignOutRequested extends AppleAuthEvent {}