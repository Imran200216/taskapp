import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskapp/core/router/app_router.dart';
import 'package:taskapp/core/styles/app_text_styles.dart';
import 'package:taskapp/features/on_boarding/view_modal/on_boarding_bloc.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/gen/fonts.gen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// hive
  await Hive.initFlutter();

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
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            // router
            routerConfig: AppRouter.router,
            title: 'Task App',
            theme: ThemeData(
              scaffoldBackgroundColor: ColorName.white,
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
          );
        },
      ),
    );
  }
}
