import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:taskapp/features/splash/view_modals/app_version_bloc/app_version_bloc.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // deciding screen
    navigateToNextScreen(context);
  }

  Future<void> navigateToNextScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    // user language preference hive box
    var userLanguagePreferenceBox = await Hive.openBox(
      "userLanguagePreferenceBox",
    );
    bool userLanguagePreferenceStatus = userLanguagePreferenceBox.get(
      "userLanguagePreferenceStatus",
      defaultValue: false,
    );

    // user on boarding hive box
    var userOnBoardingBox = await Hive.openBox("userOnBoardingStatusBox");
    bool userOnBoardingStatus = userOnBoardingBox.get(
      "userOnBoardingStatus",
      defaultValue: false,
    );

    // user auth hive box
    var userAuthBox = await Hive.openBox("userAuthStatusBox");
    bool userAuthStatus = userAuthBox.get(
      "userAuthStatus",
      defaultValue: false,
    );

    if (!context.mounted) return;

    if (userLanguagePreferenceStatus &&
        userOnBoardingStatus &&
        userAuthStatus) {
      /// Navigate to BottomNav if all conditions are true
      GoRouter.of(context).pushReplacementNamed("bottomNav");
    } else if (userLanguagePreferenceStatus && userOnBoardingStatus) {
      /// Navigate to auth screen
      GoRouter.of(context).pushReplacementNamed("auth");
    } else if (userLanguagePreferenceStatus) {
      /// Navigate to on boarding screen
      GoRouter.of(context).pushReplacementNamed("onBoarding");
    } else {
      /// Navigate to user language preference screen
      GoRouter.of(context).pushReplacementNamed("userLangPreference");
    }
  }

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: ColorName.white),
        child: Stack(
          children: [
            // top decoration
            Positioned(
              top: -130.h,
              left: -130.w,
              child: ClipRect(
                // Clip overflowing content
                child: SvgPicture.asset(
                  Assets.img.svg.decorationTop,
                  height: 240.h,
                  width: 0.w,
                  color: ColorName.primary,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // bottom decoration
            Positioned(
              bottom: -130.h,
              right: -130.w,
              child: ClipRect(
                child: Transform.rotate(
                  angle: pi,
                  child: SvgPicture.asset(
                    Assets.img.svg.decorationTop,
                    height: 240.h,
                    width: 240.w,
                    color: ColorName.primary,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // app name text
            Align(
              alignment: Alignment.center,
              child: Column(
                spacing: 12.h,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App logo
                  Image.asset(
                    Assets.icon.png.logo.path,
                    height: 100.h,
                    width: 100.w,
                    fit: BoxFit.cover,
                  ),

                  // App name
                  Text(
                    appLocalization.appName,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: ColorName.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            /// app version text
            BlocBuilder<AppVersionBloc, AppVersionState>(
              builder: (context, state) {
                if (state is AppVersionLoaded) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Text(
                        "${appLocalization.version} ${state.version}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorName.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
