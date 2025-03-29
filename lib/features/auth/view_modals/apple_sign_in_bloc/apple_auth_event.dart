part of 'apple_auth_bloc.dart';

sealed class AppleAuthEvent extends Equatable {
  const AppleAuthEvent();

  @override
  List<Object?> get props => [];
}

class AppleSignInRequested extends AppleAuthEvent {
  final BuildContext context;
  final String userUid;
  final String userLanguagePreference;

  const AppleSignInRequested({
    required this.userUid,
    required this.userLanguagePreference,
    required this.context,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [userUid, userLanguagePreference, context];
}

class AppleSignOutRequested extends AppleAuthEvent {}
