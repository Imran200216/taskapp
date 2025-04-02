import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskapp/core/locator/service_locator.dart';
import 'package:taskapp/core/router/app_router.dart';
import 'package:taskapp/core/service/local_storage/hive_storage_service.dart';
import 'package:taskapp/core/styles/app_text_styles.dart';
import 'package:taskapp/features/bottom_nav/view_modal/bottom_nav_bloc.dart';
import 'package:taskapp/features/language_preference_settings/view_modals/update_lang_preference_bloc/update_language_preference_bloc.dart';
import 'package:taskapp/features/on_boarding/view_modal/on_boarding_bloc.dart';
import 'package:taskapp/features/profile/view_modals/auth_checker_provider/auth_checker_provider_bloc.dart';
import 'package:taskapp/features/proverb/view_modal/quote_bloc/quote_bloc.dart';
import 'package:taskapp/features/splash/view_modals/app_version_bloc/app_version_bloc.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/gen/fonts.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taskapp/features/language_preference/view_modal/lang_pref_bloc/language_preference_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Setup the service locator
  await setupLocator();

  /// Retrieve stored language, default to "en"
  final box = Hive.box('userLanguagePreferenceBox');
  String storedLang = box.get("selectedLanguage", defaultValue: "en") as String;
  storedLang = _mapLanguage(storedLang).languageCode;

  runApp(MyApp(storedLang: storedLang));
}

/// Function to ensure the stored language is valid
Locale _mapLanguage(String storedLang) {
  switch (storedLang.toLowerCase()) {
    case "english":
    case "en":
      return const Locale("en");
    case "tamil":
    case "ta":
      return const Locale("ta");
    case "arabic":
    case "ar":
      return const Locale("ar");
    case "french":
    case "fr":
      return const Locale("fr");
    case "hindi":
    case "hi":
      return const Locale("hi");
    default:
      return const Locale("en");
  }
}

class MyApp extends StatefulWidget {
  final String storedLang;

  const MyApp({super.key, required this.storedLang});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    locator<HiveStorageService>().closeHive();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // on boarding bloc
        BlocProvider(create: (context) => locator.get<OnBoardingBloc>()),

        // bottom nav bloc
        BlocProvider(create: (context) => locator.get<BottomNavBloc>()),

        // language preference bloc
        BlocProvider(
          create:
              (context) =>
                  locator.get<LanguagePreferenceBloc>()
                    ..add(ToggleLanguage(language: widget.storedLang)),
        ),

        // quotes bloc
        BlocProvider(
          create: (context) => locator.get<QuoteBloc>()..add(FetchQuote()),
        ),

        // auth checker provider bloc
        BlocProvider(
          create:
              (context) =>
                  locator.get<AuthCheckerProviderBloc>()
                    ..add(CheckAuthMethod()), // Dispatch the event once
        ),

        // app version bloc
        BlocProvider(
          create:
              (context) =>
                  locator.get<AppVersionBloc>()..add(FetchAppVersion()),
        ),

        // update user language preference bloc
        BlocProvider(
          create: (context) => locator.get<UpdateLanguagePreferenceBloc>(),
        ),
      ],
      child: BlocBuilder<LanguagePreferenceBloc, LanguagePreferenceState>(
        builder: (context, state) {
          // stored lang
          String langCode = widget.storedLang;
          if (state is LangPreferenceSelected) {
            langCode = _mapLanguage(state.selectedLanguage).languageCode;
          }

          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return ToastificationWrapper(
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,

                  /// App Localization
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],

                  // supported languages
                  supportedLocales: const [
                    Locale("ta"),
                    Locale("en"),
                    Locale("ar"),
                    Locale("fr"),
                    Locale("hi"),
                  ],

                  /// Set the current locale
                  locale: Locale(langCode),

                  /// Router
                  routerConfig: locator<AppRouter>().config,

                  /// App Theme
                  title: 'Task App',
                  theme: ThemeData(
                    // scaffold bg color
                    scaffoldBackgroundColor: ColorName.white,
                    // color scheme
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: ColorName.primary,
                    ),
                    // font family
                    fontFamily: FontFamily.poppins,
                    // text theme
                    textTheme: TextTheme(
                      headlineLarge: AppTextStyles.headlineTextLarge,
                      headlineMedium: AppTextStyles.headlineTextMedium,
                      bodyLarge: AppTextStyles.bodyTextLarge,
                      bodyMedium: AppTextStyles.bodyTextMedium,
                      bodySmall: AppTextStyles.bodyTextSmall,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
