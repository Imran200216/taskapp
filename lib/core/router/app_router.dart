import 'package:go_router/go_router.dart';
import 'package:taskapp/features/auth/view/auth_forget_password_screen.dart';
import 'package:taskapp/features/auth/view/auth_screen.dart';
import 'package:taskapp/features/bottom_nav/view/bottom_nav.dart';
import 'package:taskapp/features/auth/view/auth_forget_password_success_screen.dart';
import 'package:taskapp/features/language_preference/view/user_language_preference_screen.dart';
import 'package:taskapp/features/language_preference_settings/view/language_preference_settings_screen.dart';
import 'package:taskapp/features/on_boarding/view/on_boarding_screen.dart';
import 'package:taskapp/features/splash/view/splash_screen.dart';
import 'package:taskapp/features/task_description/view/task_description_screen.dart';

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
        builder: (context, state) => const TaskDescriptionScreen(),
      ),
    ],
  );

  /// Method to access the router
  GoRouter get config => _router;
}
