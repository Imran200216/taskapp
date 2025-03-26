import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // timer to navigate to on boarding screen
    Timer(const Duration(seconds: 2), () {
      // userLangPreference screen
      GoRouter.of(context).pushReplacementNamed("userLangPreference");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: ColorName.white),
        child: Stack(
          children: [
            // top decoration
            Positioned(
              top: -130,
              left: -130,
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
              bottom: -130,
              right: -130,
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
              child: Text(
                "Tasify",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: ColorName.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            /// app version text
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Text(
                  "Version 1.0",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorName.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
