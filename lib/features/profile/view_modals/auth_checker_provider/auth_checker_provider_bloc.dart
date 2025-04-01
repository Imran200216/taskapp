import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_checker_provider_event.dart';

part 'auth_checker_provider_state.dart';

class AuthCheckerProviderBloc
    extends Bloc<AuthCheckerProviderEvent, AuthCheckerProviderState> {
  AuthCheckerProviderBloc() : super(AuthCheckerProviderInitial()) {
    on<CheckAuthMethod>((event, emit) {
      emit(_checkAuthMethod());
    });
  }

  AuthCheckerProviderState _checkAuthMethod() {
    final user = FirebaseAuth.instance.currentUser;
    print("Checking authentication method...");

    bool isEmailAuth = false;
    bool isGoogleAuth = false;
    bool isAppleAuth = false;

    if (user != null) {
      for (final provider in user.providerData) {
        print("Provider ID: ${provider.providerId}"); // Debugging log

        if (provider.providerId == 'password') {
          print("User signed in with email & password!");
          isEmailAuth = true;
        } else if (provider.providerId == 'google.com') {
          print("User signed in with Google!");
          isGoogleAuth = true;
        } else if (provider.providerId == 'apple.com') {
          print("User signed in with Apple!");
          isAppleAuth = true;
        }
      }
    }

    return AuthChecked(
      isEmailAuth: isEmailAuth,
      isGoogleAuth: isGoogleAuth,
      isAppleAuth: isAppleAuth,
    );
  }
}
