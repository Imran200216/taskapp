import 'package:go_router/go_router.dart';
import 'package:taskapp/features/auth/exports/auth_exports.dart';
import 'package:taskapp/features/bottom_nav/exports/bottom_nav_exports.dart';
import 'package:taskapp/features/language_preference/exports/language_preference_exports.dart';
import 'package:taskapp/features/language_preference_settings/exports/language_preference_settings_export.dart';
import 'package:taskapp/features/on_boarding/exports/on_boarding_exports.dart';
import 'package:taskapp/features/splash/exports/splash_exports.dart';
import 'package:taskapp/features/task_description/exports/task_description_exports.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: "/",
    routes: [
      /// splash screen
      GoRoute(
        path: "/",
        name: "splash",
        builder: (context, state) => const SplashScreen(),
      ),

      /// user language preference screen
      GoRoute(
        path: "/userLangPreference",
        name: "userLangPreference",
        builder: (context, state) => const UserLanguagePreferenceScreen(),
      ),

      /// on boarding screen
      GoRoute(
        path: "/onBoarding",
        name: "onBoarding",
        builder: (context, state) => const OnBoardingScreen(),
      ),

      /// auth screen
      GoRoute(
        path: "/auth",
        name: "auth",
        builder: (context, state) => const AuthScreen(),
      ),

      /// auth forget password screen
      GoRoute(
        path: "/authForget",
        name: "authForget",
        builder: (context, state) => const AuthForgetPasswordScreen(),
      ),

      ///  forget password success screen
      GoRoute(
        path: "/authForgetPasswordSuccess",
        name: "authForgetPasswordSuccess",
        builder: (context, state) => const AuthForgetPasswordSuccessScreen(),
      ),

      /// bottom nav screen
      GoRoute(
        path: "/bottomNav",
        name: "bottomNav",
        builder: (context, state) => const BottomNav(),
      ),

      /// language preference screen
      GoRoute(
        path: "/languagePreferenceSettings",
        name: "languagePreferenceSettings",
        builder: (context, state) => const LanguagePreferenceSettingsScreen(),
      ),

      /// task description screen
      GoRoute(
        path: "/taskDescription",
        name: "taskDescription",
        builder: (context, state) {
          final task = state.extra as Map<String, dynamic>;
          return TaskDescriptionScreen(
            taskId: task['taskId'],
            taskPriority: task['taskPriority'],
            taskStatus: task['taskStatus'],
            taskName: task['taskName'],
            taskDescription: task['taskDescription'],
            notificationAlertStatus: task['notificationAlert'] ?? false,
            dateRange: List<String>.from(task['dateRange']),
          );
        },
      ),
    ],
  );

  /// Method to access the router
  GoRouter get config => _router;
}
