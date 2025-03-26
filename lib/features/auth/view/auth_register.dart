import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:taskapp/commons/widgets/custom_icon_filled_btn.dart';
import 'package:taskapp/commons/widgets/custom_text_field.dart';
import 'package:taskapp/core/validator/app_validator.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class AuthRegister extends StatefulWidget {
  const AuthRegister({super.key});

  @override
  State<AuthRegister> createState() => _AuthRegisterState();
}

class _AuthRegisterState extends State<AuthRegister> {
  // controllers
  final TextEditingController userNameRegisterController =
      TextEditingController();
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController passwordRegisterController =
      TextEditingController();
  final TextEditingController confirmPasswordRegisterController =
      TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameRegisterController.dispose();
    emailRegisterController.dispose();
    passwordRegisterController.dispose();
    confirmPasswordRegisterController.dispose();
    super.dispose();
  }

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
              // user name  text field
              CustomTextField(
                textEditingController: userNameRegisterController,
                validator: (value) => AppValidator.validateName(value),
                hintText: appLocalization.userNameHintText,
                prefixIcon: Icons.person_outline,
              ),

              SizedBox(height: 14.h),

              // email text field
              CustomTextField(
                textEditingController: emailRegisterController,
                validator: (value) => AppValidator.validateEmail(value),
                hintText: appLocalization.emailHintText,
                prefixIcon: Icons.alternate_email,
              ),

              SizedBox(height: 14.h),

              // password text field
              CustomTextField(
                textEditingController: passwordRegisterController,
                validator: (value) => AppValidator.validatePassword(value),
                hintText: appLocalization.passwordHintText,
                isPassword: true,
                prefixIcon: Icons.lock_outline,
              ),

              SizedBox(height: 14.h),

              // confirm password text field
              CustomTextField(
                textEditingController: confirmPasswordRegisterController,
                validator:
                    (value) => AppValidator.validateConfirmPassword(
                      passwordRegisterController.text,
                      value,
                    ),
                hintText: appLocalization.confirmPasswordHintText,
                isPassword: true,
                prefixIcon: Icons.lock_outline,
              ),

              SizedBox(height: 14.h),

              Spacer(),

              // register btn
              CustomIconFilledBtn(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    // register functionality

                    // hive auth status
                    var box = Hive.box('userAuthStatusBox');
                    await box.put('userAuthStatus', true);

                    // bottom nav
                    GoRouter.of(context).pushReplacementNamed("bottomNav");
                  }
                },
                btnTitle: appLocalization.signUp,
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
