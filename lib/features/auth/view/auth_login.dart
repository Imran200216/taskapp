import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:taskapp/commons/widgets/custom_auth_social_btn.dart';
import 'package:taskapp/commons/widgets/custom_icon_filled_btn.dart';
import 'package:taskapp/commons/widgets/custom_text_field.dart';
import 'package:taskapp/core/bloc/network_checker_bloc/network_bloc.dart';
import 'package:taskapp/core/helper/snack_bar_helper.dart';
import 'package:taskapp/core/helper/toast_helper.dart';
import 'package:taskapp/core/locator/service_locator.dart';
import 'package:taskapp/core/validator/app_validator.dart';
import 'package:taskapp/features/auth/view_modals/apple_sign_in_bloc/apple_auth_bloc.dart';
import 'package:taskapp/features/auth/view_modals/email_password_bloc/email_bloc.dart';
import 'package:taskapp/features/auth/view_modals/google_sign_in_bloc/google_auth_bloc.dart';
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
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return MultiBlocProvider(
      providers: [
        // email auth  bloc
        BlocProvider(create: (context) => locator<EmailBloc>()),

        // google auth bloc
        BlocProvider(create: (context) => locator<GoogleAuthBloc>()),

        // apple auth bloc
        BlocProvider(create: (context) => locator<AppleAuthBloc>()),
      ],

      child: MultiBlocListener(
        listeners: [
          // email auth bloc
          BlocListener<EmailBloc, EmailState>(
            listener: (context, state) async {
              if (state is EmailPasswordAuthSuccess) {
                //  hive status
                var box = Hive.box('userAuthStatusBox');
                await box.put('userAuthStatus', true);

                // Navigate to the bottom navigation screen
                GoRouter.of(context).pushReplacementNamed("bottomNav");

                // Show success message
                ToastHelper.showToast(
                  context: context,
                  message: appLocalization.authSignInSuccessToast,
                  isSuccess: true,
                );
              } else if (state is EmailPasswordAuthFailure) {
                // Show error message
                ToastHelper.showToast(
                  context: context,
                  message: state.error,
                  isSuccess: false,
                );
              }
            },
          ),

          // google auth bloc
          BlocListener<GoogleAuthBloc, GoogleAuthState>(
            listener: (context, state) async {
              if (state is GoogleAuthSuccess) {
                // hive status
                var box = Hive.box('userAuthStatusBox');
                await box.put('userAuthStatus', true);

                // Navigate to the bottom navigation screen
                GoRouter.of(context).pushReplacementNamed("bottomNav");

                // Show success message
                ToastHelper.showToast(
                  context: context,
                  message: appLocalization.authSignInSuccessToast,
                  isSuccess: true,
                );
              } else if (state is GoogleAuthFailure) {
                // Show error message
                ToastHelper.showToast(
                  context: context,
                  message: state.error,
                  isSuccess: false,
                );
              }
            },
          ),

          // apple auth bloc
          BlocListener<AppleAuthBloc, AppleAuthState>(
            listener: (context, state) async {
              if (state is AppleAuthSuccess) {
                print("✅ Apple Sign-In Successful! Saving status...");

                // Save auth status in Hive
                var box = Hive.box('userAuthStatusBox');
                await box.put('userAuthStatus', true);

                // Navigate to home
                GoRouter.of(context).pushReplacementNamed("bottomNav");

                // Show success toast
                ToastHelper.showToast(
                  context: context,
                  message: appLocalization.authSignInSuccessToast,
                  isSuccess: true,
                );
              } else if (state is AppleAuthFailure) {
                print("❌ Apple Sign-In Failed: ${state.error}");

                // Show error toast
                ToastHelper.showToast(
                  context: context,
                  message: state.error,
                  isSuccess: false,
                );
              }
            },
          ),

          // network bloc
          BlocListener<NetworkBloc, NetworkState>(
            listener: (context, state) {
              if (state is NetworkSuccess) {
                // network success snack bar
                SnackBarHelper.showSnackBar(
                  context: context,
                  message: appLocalization.internetSuccessToast,
                  backgroundColor: ColorName.toastSuccessColor,
                  textColor: ColorName.white,
                  leadingIcon: Icons.signal_cellular_alt,
                );
              } else if (state is NetworkFailure) {
                // network failure snack bar
                SnackBarHelper.showSnackBar(
                  context: context,
                  message: appLocalization.internetFailureToast,
                  backgroundColor: ColorName.toastErrorColor,
                  textColor: ColorName.white,
                  leadingIcon:
                      Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                );
              }
            },
          ),
        ],

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
                  // Apple login btn
                  Platform.isIOS
                      ? BlocBuilder<AppleAuthBloc, AppleAuthState>(
                        builder: (context, state) {
                          return CustomAuthSocialBtn(
                            isLoading: state is AppleAuthLoading,
                            onTap: () async {
                              // network state
                              final networkState =
                                  context.read<NetworkBloc>().state;

                              if (networkState is NetworkFailure) {
                                // error toast
                                SnackBarHelper.showSnackBar(
                                  context: context,
                                  message: appLocalization.internetFailureToast,
                                  backgroundColor: ColorName.toastErrorColor,
                                  textColor: ColorName.white,
                                  leadingIcon:
                                      Icons
                                          .signal_cellular_connected_no_internet_4_bar_sharp,
                                );

                                return;
                              }

                              // user language preference hive box
                              final box = await Hive.openBox(
                                "userLanguagePreferenceBox",
                              );

                              /// Retrieve and print stored data
                              String storedLang = box.get("selectedLanguage");
                              String storedUserId = box.get("userId");

                              // apple sign in functionality
                              context.read<AppleAuthBloc>().add(
                                AppleSignInRequested(
                                  userUid: storedUserId,
                                  userLanguagePreference: storedLang,
                                  context: context,
                                ),
                              );
                            },
                            btnTitle: appLocalization.appleLogin,
                            iconPath: Assets.icon.svg.apple,
                          );
                        },
                      )
                      : SizedBox(),

                  SizedBox(height: 10.h),

                  // google login btn
                  BlocBuilder<GoogleAuthBloc, GoogleAuthState>(
                    builder: (context, state) {
                      return CustomAuthSocialBtn(
                        isLoading: state is GoogleAuthLoading,
                        onTap: () async {
                          // network state
                          final networkState =
                              context.read<NetworkBloc>().state;

                          if (networkState is NetworkFailure) {
                            // error toast
                            SnackBarHelper.showSnackBar(
                              context: context,
                              message: appLocalization.internetFailureToast,
                              backgroundColor: ColorName.toastErrorColor,
                              textColor: ColorName.white,
                              leadingIcon:
                                  Icons
                                      .signal_cellular_connected_no_internet_4_bar_sharp,
                            );

                            return;
                          }

                          // user language preference hive box
                          final box = await Hive.openBox(
                            "userLanguagePreferenceBox",
                          );

                          /// Retrieve and print stored data
                          String storedLang = box.get("selectedLanguage");
                          String storedUserId = box.get("userId");

                          // google sign in functionality
                          context.read<GoogleAuthBloc>().add(
                            SignInWithGoogleEvent(
                              context: context,
                              userUid: storedUserId,
                              userLanguagePreference: storedLang,
                            ),
                          );
                        },
                        btnTitle: appLocalization.googleLogin,
                        iconPath: Assets.icon.svg.google,
                      );
                    },
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
                    textEditingController: emailLoginController,
                    validator:
                        (value) => AppValidator.validateEmail(context, value),
                    hintText: appLocalization.emailHintText,
                    prefixIcon: Icons.alternate_email,
                  ),

                  SizedBox(height: 14.h),

                  // password text field
                  CustomTextField(
                    textEditingController: passwordLoginController,
                    validator:
                        (value) =>
                            AppValidator.validatePassword(context, value),
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
                  BlocBuilder<EmailBloc, EmailState>(
                    builder: (context, state) {
                      return CustomIconFilledBtn(
                        onTap: () {
                          // network state
                          final networkState =
                              context.read<NetworkBloc>().state;

                          if (networkState is NetworkFailure) {
                            // error toast
                            SnackBarHelper.showSnackBar(
                              context: context,
                              message: appLocalization.internetFailureToast,
                              backgroundColor: ColorName.toastErrorColor,
                              textColor: ColorName.white,
                              leadingIcon:
                                  Icons
                                      .signal_cellular_connected_no_internet_4_bar_sharp,
                            );

                            return;
                          }

                          if (formKey.currentState!.validate()) {
                            //  Sign In functionality
                            context.read<EmailBloc>().add(
                              SignInEvent(
                                email: emailLoginController.text.trim(),
                                password: passwordLoginController.text.trim(),
                                context: context,
                              ),
                            );
                          }
                        },
                        btnTitle: appLocalization.login,
                        iconPath: Assets.icon.svg.login,
                        isLoading: state is EmailPasswordAuthLoading,
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
