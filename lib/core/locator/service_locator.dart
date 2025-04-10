import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:taskapp/core/bloc/network_checker_bloc/network_bloc.dart';
import 'package:taskapp/core/router/app_router.dart';
import 'package:taskapp/core/service/add_task/add_task_service.dart';
import 'package:taskapp/core/service/auth/apple_auth_service.dart';
import 'package:taskapp/core/service/auth/email_password_auth_service.dart';
import 'package:taskapp/core/service/auth/google_auth_service.dart';
import 'package:taskapp/core/service/local_storage/hive_storage_service.dart';
import 'package:taskapp/core/service/network/network_service.dart';
import 'package:taskapp/core/service/notification/local_notification.dart';
import 'package:taskapp/core/service/quote_api_service/quote_service.dart';
import 'package:taskapp/features/add_task/view_modals/add_task_bloc/add_task_bloc.dart';
import 'package:taskapp/features/auth/view_modals/apple_sign_in_bloc/apple_auth_bloc.dart';
import 'package:taskapp/features/auth/view_modals/email_password_bloc/email_bloc.dart';
import 'package:taskapp/features/auth/view_modals/google_sign_in_bloc/google_auth_bloc.dart';
import 'package:taskapp/features/bottom_nav/view_modal/bottom_nav_bloc.dart';
import 'package:taskapp/features/home/view_modals/selection_chip_bloc/selection_chip_bloc.dart';
import 'package:taskapp/features/home/view_modals/view_task_bloc/view_task_bloc.dart';
import 'package:taskapp/features/language_preference/view_modal/lang_pref_bloc/language_preference_bloc.dart';
import 'package:taskapp/features/language_preference_settings/view_modals/update_lang_preference_bloc/update_language_preference_bloc.dart';
import 'package:taskapp/features/on_boarding/view_modal/on_boarding_bloc.dart';
import 'package:taskapp/features/profile/view_modals/auth_checker_provider/auth_checker_provider_bloc.dart';
import 'package:taskapp/features/proverb/view_modal/quote_bloc/quote_bloc.dart';
import 'package:taskapp/features/splash/view_modals/app_version_bloc/app_version_bloc.dart';
import 'package:taskapp/firebase_options.dart';
import 'package:timezone/data/latest_all.dart' as tz;

/// locator of get it
final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Initialize Timezones FIRST
  tz.initializeTimeZones();

  /// Register services AFTER timezone setup
  locator.registerLazySingleton<NotificationService>(
    () => NotificationService(),
  );

  /// Optionally: initialize services immediately after registering


  // Register HiveStorageService as an async singleton
  locator.registerSingletonAsync<HiveStorageService>(() async {
    final service = HiveStorageService();
    await service.init();
    return service;
  });

  // Wait for the async registration to complete
  await locator.allReady();

  // quotes service
  locator.registerLazySingleton(() => QuoteService());

  // Add Task Service
  locator.registerLazySingleton(() => AddTaskService());

  // network service
  locator.registerLazySingleton(() => NetworkService());

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
  locator.registerFactory(() => AuthCheckerProviderBloc());

  // Add Task Bloc
  locator.registerFactory(() => AddTaskBloc(locator<AddTaskService>()));

  // App version Bloc
  locator.registerFactory(() => AppVersionBloc());

  // Update user language preference bloc
  locator.registerFactory(() => UpdateLanguagePreferenceBloc());

  // Selection chip Bloc
  locator.registerFactory(() => SelectionChipBloc());

  // Internet Checker Bloc
  locator.registerLazySingleton<NetworkBloc>(() => NetworkBloc());

  // View task Bloc
  locator.registerFactory(() => ViewTaskBloc());

  /// Router
  locator.registerLazySingleton<AppRouter>(() => AppRouter());
}
