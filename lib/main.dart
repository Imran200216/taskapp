import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskapp/core/locator/service_locator.dart';
import 'package:taskapp/core/router/app_router.dart';
import 'package:taskapp/core/styles/app_text_styles.dart';
import 'package:taskapp/features/bottom_nav/view_modal/bottom_nav_bloc.dart';
import 'package:taskapp/features/on_boarding/view_modal/on_boarding_bloc.dart';
import 'package:taskapp/features/proverb/view_modal/quote_bloc/quote_bloc.dart';
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
      return Locale("en");
    case "tamil":
    case "ta":
      return Locale("ta");
    case "arabic":
    case "ar":
      return Locale("ar");
    case "french":
    case "fr":
      return Locale("fr");
    default:
      return Locale("en");
  }
}

class MyApp extends StatelessWidget {
  final String storedLang;

  const MyApp({super.key, required this.storedLang});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<OnBoardingBloc>()),
        BlocProvider(create: (context) => locator<BottomNavBloc>()),
        BlocProvider(
          create:
              (context) =>
                  locator<LanguagePreferenceBloc>()
                    ..add(ToggleLanguage(language: storedLang)),
        ),
        BlocProvider(
          create: (context) => locator<QuoteBloc>()..add(FetchQuote()),
        ),
      ],
      child: BlocBuilder<LanguagePreferenceBloc, LanguagePreferenceState>(
        builder: (context, state) {
          String langCode = storedLang;
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
                  supportedLocales: const [
                    Locale("ta"),
                    Locale("en"),
                    Locale("ar"),
                    Locale("fr"),
                  ],

                  /// Set the current locale
                  locale: Locale(langCode),

                  /// Router
                  routerConfig: locator<AppRouter>().config,

                  /// App Theme
                  title: 'Task App',
                  theme: ThemeData(
                    scaffoldBackgroundColor: ColorName.white,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: ColorName.primary,
                    ),
                    fontFamily: FontFamily.poppins,
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
