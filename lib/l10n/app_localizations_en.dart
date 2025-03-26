// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get authTitle => 'Welcome to TaskNotify';

  @override
  String get authSubTitle => 'Sign up or login below to manage your project, task and your productivity';

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get appleLogin => 'Login with Apple';

  @override
  String get googleLogin => 'Login with Google';

  @override
  String get continueWithEmail => 'or continue with email';

  @override
  String get userNameHintText => 'Enter your name';

  @override
  String get emailHintText => 'Enter your email';

  @override
  String get passwordHintText => 'Enter your password';

  @override
  String get confirmPasswordHintText => 'Enter your confirm password';

  @override
  String get forgetPassword => 'Forget Password?';

  @override
  String get forgetPasswordTitle => 'Forget Password';

  @override
  String get forgetPasswordSubTitle => 'Enter your email account to reset password';

  @override
  String get continueText => 'Continue';

  @override
  String get backToLoginText => 'Back to Login';
}
