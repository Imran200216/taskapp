import 'package:go_router/go_router.dart';
import 'package:taskapp/features/auth/view/auth_forget_password_screen.dart';
import 'package:taskapp/features/auth/view/auth_screen.dart';
import 'package:taskapp/features/bottom_nav/view/bottom_nav.dart';
import 'package:taskapp/features/contact/view/contact_screen.dart';
import 'package:taskapp/features/language_preference/view/user_language_preference_screen.dart';
import 'package:taskapp/features/on_boarding/view/on_boarding_screen.dart';
import 'package:taskapp/features/splash/view/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/contact",
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

      /// bottom nav screen
      GoRoute(
        path: "/bottomNav",
        name: "bottomNav",
        builder: (context, state) => const BottomNav(),
      ),

      /// contact screen
      GoRoute(
        path: "/contact",
        name: "contact",
        builder: (context, state) => const ContactScreen(),
      ),
    ],
  );
}
