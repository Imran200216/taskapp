part of 'auth_checker_provider_bloc.dart';

sealed class AuthCheckerProviderEvent extends Equatable {
  const AuthCheckerProviderEvent();
}

class CheckAuthMethod extends AuthCheckerProviderEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
