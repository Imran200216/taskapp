import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskapp/core/router/app_router.dart';
import 'package:taskapp/core/service/quote_service.dart';
import 'package:taskapp/core/styles/app_text_styles.dart';
import 'package:taskapp/features/bottom_nav/view_modal/bottom_nav_bloc.dart';
import 'package:taskapp/features/language_preference/view_modal/lang_pref_bloc/language_preference_bloc.dart';
import 'package:taskapp/features/on_boarding/view_modal/on_boarding_bloc.dart';
import 'package:taskapp/features/proverb/view_modal/quote_bloc/quote_bloc.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/gen/fonts.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  /// safe area bg color
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: ColorName.primary.withOpacity(0.6)),
  );

  /// hive
  await Hive.initFlutter();

  /// language preference box
  await Hive.openBox('userLanguagePreferenceBox');

  // Open Hive box
  final box = await Hive.openBox("userLanguagePreferenceBox");

  // Retrieve stored language or set default (English)
  String selectedLanguage = box.get("selectedLanguage", defaultValue: "en");

  /// on boarding status box
  await Hive.openBox('userOnBoardingStatusBox');

  /// auth status box
  await Hive.openBox('userAuthStatusBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // on boarding bloc
        BlocProvider(create: (context) => OnBoardingBloc()),

        // bottom nav bloc
        BlocProvider(create: (context) => BottomNavBloc()),

        // user language preference bloc
        BlocProvider(create: (context) => LanguagePreferenceBloc()),

        // quotes bloc
        BlocProvider(
          create: (context) => QuoteBloc(QuoteService())..add(FetchQuote()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return ToastificationWrapper(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              // app localization
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                // tamil
                Locale("ta"),
                // english
                Locale("en"),
                // arabic
                Locale("ar"),
              ],
              // current app localization
              locale: Locale("en"),
              // router
              routerConfig: AppRouter.router,
              title: 'Task App',
              theme: ThemeData(
                // scaffold bg color
                scaffoldBackgroundColor: ColorName.white,
                // colors
                colorScheme: ColorScheme.fromSeed(seedColor: ColorName.primary),
                // font family
                fontFamily: FontFamily.poppins,
                //  text themes
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
      ),
    );
  }
}
