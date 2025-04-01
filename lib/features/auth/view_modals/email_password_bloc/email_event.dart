part of 'email_bloc.dart';

sealed class EmailEvent extends Equatable {
  const EmailEvent();
}

class SignUpEvent extends EmailEvent {
  final BuildContext context;
  final String userUid;
  final String email;
  final String password;
  final String name;
  final String userLanguagePreference;

  const SignUpEvent({
    required this.context,
    required this.userUid,
    required this.email,
    required this.password,
    required this.name,
    required this.userLanguagePreference,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    context,
    email,
    password,
    name,
    userLanguagePreference,
    userUid,
  ];
}

class SignInEvent extends EmailEvent {
  final BuildContext context;
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [email, password, context];
}

class ResetPasswordEvent extends EmailEvent {
  final String email;
  final BuildContext context;

  const ResetPasswordEvent({required this.email, required this.context});

  @override
  // TODO: implement props
  List<Object?> get props => [email];
}

class SignOutEvent extends EmailEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
