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
  final bool isGoogleAuth;
  final bool isAppleAuth;

  const AuthChecked({
    required this.isEmailAuth,
    required this.isGoogleAuth,
    required this.isAppleAuth,
  });

  @override
  List<Object?> get props => [isEmailAuth, isGoogleAuth, isAppleAuth];
}


