part of 'auth_checker_provider_bloc.dart';

sealed class AuthCheckerProviderState extends Equatable {
  const AuthCheckerProviderState();
}

final class AuthCheckerProviderInitial extends AuthCheckerProviderState {
  @override
  List<Object> get props => [];
}

class AuthChecked extends AuthCheckerProviderState {
  final bool isEmailAuth;
  const AuthChecked(this.isEmailAuth);

  @override
  // TODO: implement props
  List<Object?> get props => [isEmailAuth];
}

