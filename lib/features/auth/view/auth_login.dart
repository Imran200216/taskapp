import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:taskapp/commons/widgets/custom_auth_social_btn.dart';
import 'package:taskapp/commons/widgets/custom_icon_filled_btn.dart';
import 'package:taskapp/commons/widgets/custom_text_field.dart';
import 'package:taskapp/core/validator/app_validator.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin({super.key});

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  // controllers
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(color: ColorName.authTabBarBgColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Apple login btn
              CustomAuthSocialBtn(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    // apple sign in  functionality

                    // hive auth status
                    var box = Hive.box('userAuthStatusBox');
                    await box.put('userAuthStatus', true);
                  }
                },
                btnTitle: appLocalization.appleLogin,
                iconPath: Assets.icon.svg.apple,
              ),

              SizedBox(height: 10.h),

              // google login btn
              CustomAuthSocialBtn(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    // google sign in  functionality

                    // hive auth status
                    var box = Hive.box('userAuthStatusBox');
                    await box.put('userAuthStatus', true);
                  }
                },
                btnTitle: appLocalization.googleLogin,
                iconPath: Assets.icon.svg.google,
              ),

              SizedBox(height: 20.h),

              //  or continue with email text
              Text(
                textAlign: TextAlign.center,
                appLocalization.continueWithEmail,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorName.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 20.h),

              // email text field
              CustomTextField(
                validator: (value) => AppValidator.validateEmail(value),
                hintText: appLocalization.emailHintText,
                prefixIcon: Icons.alternate_email,
              ),

              SizedBox(height: 14.h),

              // password text field
              CustomTextField(
                validator: (value) => AppValidator.validatePassword(value),
                hintText: appLocalization.passwordHintText,
                isPassword: true,
                prefixIcon: Icons.lock_outline,
              ),

              SizedBox(height: 14.h),

              // forget password text btn
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    // forget password screen
                    GoRouter.of(context).pushNamed("authForget");
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    appLocalization.forgetPassword,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorName.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              Spacer(),

              // login btn
              CustomIconFilledBtn(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    // login in functionality

                    // hive auth status
                    var box = Hive.box('userAuthStatusBox');
                    await box.put('userAuthStatus', true);

                    // bottom nav screen
                    GoRouter.of(context).pushReplacementNamed("bottomNav");
                  }
                },
                btnTitle: appLocalization.login,
                iconPath: Assets.icon.svg.login,
              ),

              SizedBox(height: 14.h),
            ],
          ),
        ),
      ),
    );
  }
}
