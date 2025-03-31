import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_checker_provider_event.dart';
part 'auth_checker_provider_state.dart';

class AuthCheckerProviderBloc extends Bloc<AuthCheckerProviderEvent, AuthCheckerProviderState> {
  AuthCheckerProviderBloc() : super(AuthCheckerProviderInitial()) {
    on<CheckAuthMethod>((event, emit) {
      emit(_checkAuthMethod());
    });
  }

  AuthCheckerProviderState _checkAuthMethod() {
    final user = FirebaseAuth.instance.currentUser;
    print("Checking authentication method...");

    if (user != null) {
      for (final provider in user.providerData) {
        print("Provider ID: ${provider.providerId}");  // Debugging log

        if (provider.providerId == 'password') {
          print("User signed in with email & password!");
          return AuthChecked(true);
        }
      }
    }

    print("User signed in with Google or Apple!");
    return AuthChecked(false);
  }
}
