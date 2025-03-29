part of 'apple_auth_bloc.dart';

sealed class AppleAuthState extends Equatable {
  const AppleAuthState();
}

final class AppleAuthInitial extends AppleAuthState {
  @override
  List<Object> get props => [];
}



class AppleAuthLoading extends AppleAuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AppleAuthSuccess extends AppleAuthState {
  final User user;

  const AppleAuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AppleAuthSignedOut extends AppleAuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AppleAuthFailure extends AppleAuthState {
  final String error;

  const AppleAuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}