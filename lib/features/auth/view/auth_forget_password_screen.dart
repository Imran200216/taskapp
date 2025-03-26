import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/commons/widgets/custom_icon_filled_btn.dart';
import 'package:taskapp/commons/widgets/custom_text_field.dart';
import 'package:taskapp/core/helper/toast_helper.dart';
import 'package:taskapp/core/validator/app_validator.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class AuthForgetPasswordScreen extends StatefulWidget {
  const AuthForgetPasswordScreen({super.key});

  @override
  State<AuthForgetPasswordScreen> createState() =>
      _AuthForgetPasswordScreenState();
}

class _AuthForgetPasswordScreenState extends State<AuthForgetPasswordScreen> {
  // controllers
  final TextEditingController emailForgetPasswordController =
      TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// title
                  Text(
                    textAlign: TextAlign.center,
                    appLocalization.forgetPasswordTitle,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorName.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Description
                  Text(
                    textAlign: TextAlign.center,
                    appLocalization.forgetPasswordSubTitle,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorName.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Spacer(),

                  // forget password svg
                  SvgPicture.asset(
                    Assets.img.svg.forgetPassword,
                    height: 0.22.sh,
                    fit: BoxFit.cover,
                  ),

                  Spacer(flex: 3),

                  // email text field
                  CustomTextField(
                    textEditingController: emailForgetPasswordController,
                    validator: (value) => AppValidator.validateEmail(value),
                    hasBorder: true,
                    hintText: appLocalization.emailHintText,
                    prefixIcon: Icons.alternate_email,
                  ),

                  SizedBox(height: 14.h),

                  // sent link continue btn
                  CustomIconFilledBtn(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        // sent link functionality
                      } else {
                        ToastHelper.showToast(
                          context: context,
                          message: "Error occured",
                          isSuccess: false,
                        );
                      }
                    },
                    btnTitle: appLocalization.continueText,
                    iconPath: Assets.icon.svg.login,
                  ),

                  SizedBox(height: 14.h),

                  // back to login text btn
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        // login screen
                        GoRouter.of(context).pushNamed("auth");
                      },
                      child: Text(
                        textAlign: TextAlign.center,
                        appLocalization.backToLoginText,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorName.primary,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorName.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
