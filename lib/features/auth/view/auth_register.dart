import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:taskapp/commons/widgets/custom_icon_filled_btn.dart';
import 'package:taskapp/commons/widgets/custom_text_field.dart';
import 'package:taskapp/core/helper/toast_helper.dart';
import 'package:taskapp/core/locator/service_locator.dart';
import 'package:taskapp/core/validator/app_validator.dart';
import 'package:taskapp/features/auth/view_modals/email_password_bloc/email_bloc.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class AuthRegister extends StatefulWidget {
  const AuthRegister({super.key});

  @override
  State<AuthRegister> createState() => _AuthRegisterState();
}

class _AuthRegisterState extends State<AuthRegister> {
  // Controllers
  final TextEditingController userNameRegisterController =
      TextEditingController();
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController passwordRegisterController =
      TextEditingController();
  final TextEditingController confirmPasswordRegisterController =
      TextEditingController();

  // Form key
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
    final appLocalization = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) => locator<EmailBloc>(),
      child: BlocListener<EmailBloc, EmailState>(
        listener: (context, state) async {
          if (state is EmailPasswordAuthSuccess) {
            // Save auth status in Hive
            var box = Hive.box('userAuthStatusBox');
            await box.put('userAuthStatus', true);

            // Navigate to bottom navigation screen
            GoRouter.of(context).pushReplacementNamed("bottomNav");

            // Show success message
            ToastHelper.showToast(
              context: context,
              message: "Sign Up successfully",
              isSuccess: true,
            );
          } else if (state is EmailPasswordAuthFailure) {
            // Close loading dialog
            Navigator.of(context).pop();

            // Show error message
            ToastHelper.showToast(
              context: context,
              message: state.error,
              isSuccess: false,
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(color: ColorName.authTabBarBgColor),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // User name text field
                  CustomTextField(
                    textEditingController: userNameRegisterController,
                    validator:
                        (value) => AppValidator.validateName(context, value),
                    hintText: appLocalization.userNameHintText,
                    prefixIcon: Icons.person_outline,
                  ),

                  SizedBox(height: 14.h),

                  // Email text field
                  CustomTextField(
                    textEditingController: emailRegisterController,
                    validator:
                        (value) => AppValidator.validateEmail(context, value),
                    hintText: appLocalization.emailHintText,
                    prefixIcon: Icons.alternate_email,
                  ),

                  SizedBox(height: 14.h),

                  // Password text field
                  CustomTextField(
                    textEditingController: passwordRegisterController,
                    validator:
                        (value) =>
                            AppValidator.validatePassword(context, value),
                    hintText: appLocalization.passwordHintText,
                    isPassword: true,
                    prefixIcon: Icons.lock_outline,
                  ),

                  SizedBox(height: 14.h),

                  // Confirm password text field
                  CustomTextField(
                    textEditingController: confirmPasswordRegisterController,
                    validator:
                        (value) => AppValidator.validateConfirmPassword(
                          context,
                          passwordRegisterController.text,
                          value,
                        ),
                    hintText: appLocalization.confirmPasswordHintText,
                    isPassword: true,
                    prefixIcon: Icons.lock_outline,
                  ),

                  SizedBox(height: 14.h),

                  Spacer(),

                  // Register button
                  BlocBuilder<EmailBloc, EmailState>(
                    builder: (context, state) {
                      return CustomIconFilledBtn(
                        isLoading: state is EmailPasswordAuthLoading,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            // user language preference hive box
                            final box = await Hive.openBox(
                              "userLanguagePreferenceBox",
                            );

                            /// Retrieve and print stored data
                            String storedLang = box.get("selectedLanguage");
                            String storedUserId = box.get("userId");

                            // Sign Up functionality
                            context.read<EmailBloc>().add(
                              SignUpEvent(
                                name: userNameRegisterController.text.trim(),
                                email: emailRegisterController.text.trim(),
                                password:
                                    passwordRegisterController.text.trim(),
                                userLanguagePreference: storedLang,
                                userUid: storedUserId,
                                context: context,
                              ),
                            );
                          }
                        },
                        btnTitle: appLocalization.signUp,
                        iconPath: Assets.icon.svg.login,
                      );
                    },
                  ),

                  SizedBox(height: 14.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
