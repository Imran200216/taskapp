part of 'email_bloc.dart';

sealed class EmailState extends Equatable {
  const EmailState();
}

final class EmailInitial extends EmailState {
  @override
  List<Object> get props => [];
}

class EmailPasswordAuthLoading extends EmailState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EmailPasswordAuthSuccess extends EmailState {
  final String message;

  const EmailPasswordAuthSuccess(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class EmailPasswordAuthFailure extends EmailState {
  final String error;

  const EmailPasswordAuthFailure(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

/// **Sign-Out States**
class EmailSignOutLoading extends EmailState {
  @override
  List<Object?> get props => [];
}

class EmailSignOutSuccess extends EmailState {
  final String message;

  const EmailSignOutSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class EmailSignOutFailure extends EmailState {
  final String error;

  const EmailSignOutFailure(this.error);

  @override
  List<Object?> get props => [error];
}
