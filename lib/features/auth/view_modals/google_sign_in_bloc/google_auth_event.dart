part of 'google_auth_bloc.dart';

sealed class GoogleAuthEvent extends Equatable {
  const GoogleAuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInWithGoogleEvent extends GoogleAuthEvent {
  final BuildContext context;
  final String userUid;

  final String userLanguagePreference;

  const SignInWithGoogleEvent({
    required this.context,
    required this.userUid,

    required this.userLanguagePreference,
  });

  @override
  List<Object?> get props => [userUid, userLanguagePreference];
}

class GoogleAuthSignOutEvent extends GoogleAuthEvent {
  @override
  List<Object?> get props => [];
}

