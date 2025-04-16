import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:taskapp/core/core_exports.dart';
import 'package:taskapp/l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';
import 'package:taskapp/features/bottom_nav/bottom_nav_exports.dart';
import 'package:taskapp/features/home/home_exports.dart';
import 'package:taskapp/features/language_preference/language_preference_exports.dart';
import 'package:taskapp/features/language_preference_settings/language_preference_settings_export.dart';
import 'package:taskapp/features/on_boarding/on_boarding_exports.dart';
import 'package:taskapp/features/profile/profile_exports.dart';
import 'package:taskapp/features/proverb/proverb_exports.dart';
import 'package:taskapp/features/splash/splash_exports.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'features/archive/archive_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Setup the service locator
  await setupLocator();

  // local notification init
  await NotificationService.init();

  /// Retrieve stored language, fallback to null
  final box = Hive.box('userLanguagePreferenceBox');
  final String? storedLang = box.get("selectedLanguage");

  runApp(MyApp(storedLang: storedLang));
}

class MyApp extends StatefulWidget {
  final String? storedLang;

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
    // lang code
    final String initialLangCode =
        widget.storedLang != null
            ? mapLanguage(widget.storedLang!).languageCode
            : "en";

    return MultiBlocProvider(
      providers: [
        // on boarding bloc
        BlocProvider(create: (context) => locator.get<OnBoardingBloc>()),

        // bottom bloc
        BlocProvider(create: (context) => locator.get<BottomNavBloc>()),

        /// Language Preference Bloc
        BlocProvider(
          create: (context) {
            final bloc = locator.get<LanguagePreferenceBloc>();
            if (widget.storedLang != null) {
              bloc.add(
                ToggleLanguage(
                  language: widget.storedLang!,
                  isUserSelected: false,
                ),
              );
            }
            return bloc;
          },
        ),

        // quote bloc
        BlocProvider(
          create: (context) => locator.get<QuoteBloc>()..add(FetchQuote()),
        ),

        // check auth method
        BlocProvider(
          create:
              (context) =>
                  locator.get<AuthCheckerProviderBloc>()
                    ..add(CheckAuthMethod()),
        ),

        // fetch app version bloc
        BlocProvider(
          create:
              (context) =>
                  locator.get<AppVersionBloc>()..add(FetchAppVersion()),
        ),

        // update lang pref bloc
        BlocProvider(
          create: (context) => locator.get<UpdateLanguagePreferenceBloc>(),
        ),

        // selection chip bloc
        BlocProvider(create: (context) => locator.get<SelectionChipBloc>()),

        // network bloc
        BlocProvider(
          create:
              (context) => locator.get<NetworkBloc>()..add(NetworkObserve()),
          lazy: false,
        ),

        // view task bloc
        BlocProvider(create: (context) => locator.get<ViewTaskBloc>()),

        // view archive task bloc
        BlocProvider(create: (context) => locator.get<ViewArchiveTaskBloc>()),
      ],
      child: BlocBuilder<LanguagePreferenceBloc, LanguagePreferenceState>(
        builder: (context, state) {
          String langCode = initialLangCode;

          if (state is LangPreferenceSelected) {
            langCode = mapLanguage(state.selectedLanguage).languageCode;
          }

          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return ToastificationWrapper(
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: supportedLocales,
                  locale: Locale(langCode),
                  routerConfig: locator<AppRouter>().config,
                  title: 'TaskNotify',
                  theme: AppTheme.lightTheme,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
