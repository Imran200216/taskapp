import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:taskapp/firebase_options.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:taskapp/features/archive/archive_exports.dart';
import 'package:taskapp/features/task_description/task_description_exports.dart';
import 'package:taskapp/core/core_exports.dart';
import 'package:taskapp/features/add_task/add_task_exports.dart';
import 'package:taskapp/features/auth/auth_exports.dart';
import 'package:taskapp/features/bottom_nav/bottom_nav_exports.dart';
import 'package:taskapp/features/home/home_exports.dart';
import 'package:taskapp/features/language_preference/language_preference_exports.dart';
import 'package:taskapp/features/language_preference_settings/language_preference_settings_export.dart';
import 'package:taskapp/features/on_boarding/on_boarding_exports.dart';
import 'package:taskapp/features/profile/profile_exports.dart';
import 'package:taskapp/features/proverb/proverb_exports.dart';
import 'package:taskapp/features/splash/splash_exports.dart';

/// locator of get it
final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Initialize Timezones FIRST
  tz.initializeTimeZones();

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
  locator.registerLazySingleton(() => TaskService());

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
  locator.registerFactory(() => AddTaskBloc(locator<TaskService>()));

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

  // Archive Task Bloc
  locator.registerFactory(() => TaskArchiveBloc(locator<TaskService>()));

  // View Archive Task Bloc
  locator.registerFactory(() => ViewArchiveTaskBloc(locator<TaskService>()));

  /// Router
  locator.registerLazySingleton<AppRouter>(() => AppRouter());
}
