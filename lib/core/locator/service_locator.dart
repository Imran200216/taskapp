import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskapp/core/router/app_router.dart';
import 'package:taskapp/core/service/auth/apple_auth_service.dart';
import 'package:taskapp/core/service/auth/email_password_auth_service.dart';
import 'package:taskapp/core/service/auth/google_auth_service.dart';
import 'package:taskapp/core/service/quote_service.dart';
import 'package:taskapp/features/auth/view_modals/apple_sign_in_bloc/apple_auth_bloc.dart';
import 'package:taskapp/features/auth/view_modals/email_password_bloc/email_bloc.dart';
import 'package:taskapp/features/auth/view_modals/google_sign_in_bloc/google_auth_bloc.dart';
import 'package:taskapp/features/bottom_nav/view_modal/bottom_nav_bloc.dart';
import 'package:taskapp/features/language_preference/view_modal/lang_pref_bloc/language_preference_bloc.dart';
import 'package:taskapp/features/on_boarding/view_modal/on_boarding_bloc.dart';
import 'package:taskapp/features/proverb/view_modal/quote_bloc/quote_bloc.dart';
import 'package:taskapp/firebase_options.dart';

/// locator of get it
final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Initialize Hive
  await Hive.initFlutter();

  /// Open Hive boxes
  await Hive.openBox('userLanguagePreferenceBox');
  await Hive.openBox('userOnBoardingStatusBox');
  await Hive.openBox('userAuthStatusBox');

  /// Services
  locator.registerLazySingleton(() => QuoteService());

  /// Auth Services
  locator.registerLazySingleton(() => EmailPasswordAuthService());
  locator.registerLazySingleton(() => AppleAuthService());
  locator.registerLazySingleton(() => GoogleAuthService());

  /// Blocs
  locator.registerFactory(() => OnBoardingBloc());
  locator.registerFactory(() => BottomNavBloc());
  locator.registerFactory(() => LanguagePreferenceBloc());
  locator.registerFactory(() => QuoteBloc(locator<QuoteService>()));

  // Auth Blocs
  locator.registerFactory(() => EmailBloc(locator<EmailPasswordAuthService>()));
  locator.registerFactory(() => GoogleAuthBloc(locator<GoogleAuthService>()));
  locator.registerFactory(() => AppleAuthBloc(locator<AppleAuthService>()));

  /// Router
  locator.registerLazySingleton<AppRouter>(() => AppRouter());
}
