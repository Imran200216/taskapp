part of 'google_auth_bloc.dart';

sealed class GoogleAuthState extends Equatable {
  const GoogleAuthState();
}

final class GoogleAuthInitial extends GoogleAuthState {
  @override
  List<Object> get props => [];
}

class GoogleAuthLoading extends GoogleAuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GoogleAuthSuccess extends GoogleAuthState {
  final User user;

  const GoogleAuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class GoogleAuthFailure extends GoogleAuthState {
  final String error;

  const GoogleAuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class GoogleAuthSignOutSuccess extends GoogleAuthState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
