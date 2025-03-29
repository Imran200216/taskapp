part of 'google_auth_bloc.dart';

sealed class GoogleAuthEvent extends Equatable {
  const GoogleAuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInWithGoogleEvent extends GoogleAuthEvent {
  final BuildContext context;
  final String userUid;
  final String email;
  final String name;
  final String userLanguagePreference;

  const SignInWithGoogleEvent({
    required this.context,
    required this.userUid,
    required this.email,
    required this.name,
    required this.userLanguagePreference,
  });

  @override
  List<Object?> get props => [userUid, email, name, userLanguagePreference];
}

class SignOutFromGoogleEvent extends GoogleAuthEvent {
  final BuildContext context;

  const SignOutFromGoogleEvent({required this.context});
}
