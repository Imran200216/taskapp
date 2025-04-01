import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/commons/widgets/custom_icon_filled_btn.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class AuthForgetPasswordSuccessScreen extends StatelessWidget {
  const AuthForgetPasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              spacing: 10.h,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // forget password success svg
                SvgPicture.asset(
                  Assets.img.svg.forgetPasswordSuccess,
                  height: 0.16.sh,
                  fit: BoxFit.cover,
                ),

                // Check your mail text
                Text(
                  textAlign: TextAlign.center,
                  appLocalization.forgetPasswordTitle,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    color: ColorName.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // Subtitle text
                Text(
                  textAlign: TextAlign.center,
                  appLocalization.forgetPasswordSubTitle,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 12.sp,
                    color: ColorName.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 12.h),

                // go to sign in btn
                CustomIconFilledBtn(
                  onTap: () {
                    // auth screen
                    GoRouter.of(context).pushReplacementNamed("auth");
                  },
                  btnTitle: appLocalization.goToSignIn,
                  iconPath: Assets.icon.svg.login,
                ),

                // skip i will confirm later txt btn
                TextButton(
                  onPressed: () {
                    // auth forget password screen
                    GoRouter.of(context).pushReplacementNamed("authForget");
                  },
                  child: Text(
                    appLocalization.skipLater,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 8.sp,
                      color: ColorName.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
