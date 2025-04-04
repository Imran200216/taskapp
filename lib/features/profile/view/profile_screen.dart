import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:taskapp/core/bloc/network_checker_bloc/network_bloc.dart';
import 'package:taskapp/core/constants/app_constants.dart';
import 'package:taskapp/core/helper/snack_bar_helper.dart';
import 'package:taskapp/core/helper/toast_helper.dart';
import 'package:taskapp/core/locator/service_locator.dart';
import 'package:taskapp/features/auth/view_modals/apple_sign_in_bloc/apple_auth_bloc.dart';
import 'package:taskapp/features/auth/view_modals/email_password_bloc/email_bloc.dart';
import 'package:taskapp/features/auth/view_modals/google_sign_in_bloc/google_auth_bloc.dart';
import 'package:taskapp/features/language_preference_settings/view_modals/update_lang_preference_bloc/update_language_preference_bloc.dart';
import 'package:taskapp/features/profile/view_modals/auth_checker_provider/auth_checker_provider_bloc.dart';
import 'package:taskapp/features/profile/widgets/custom_email_person_avatar.dart';
import 'package:taskapp/features/profile/widgets/custom_person_avatar.dart';
import 'package:taskapp/features/profile/widgets/custom_profile_list_tile.dart';
import 'package:taskapp/features/profile/widgets/custom_profile_thanks_text.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    // current user
    final User? currentUser = FirebaseAuth.instance.currentUser;
    // current user name
    final currentUserName = currentUser?.displayName ?? "No Name";
    // current user email
    final currentUserEmail = currentUser?.email ?? "No Email";

    // Handle user logout status
    Future<void> handleUserLogout(BuildContext context) async {
      // ✅ Open Hive box for language preference
      final userLanguagePreferenceBox = await Hive.openBox(
        "userLanguagePreferenceBox",
      );

      // ✅ Temporarily store the original selected language before logout
      String originalLanguage = userLanguagePreferenceBox.get(
        "selectedLanguage",
        defaultValue: "English",
      );

      await userLanguagePreferenceBox.put(
        "originalSelectedLanguage",
        originalLanguage,
      );
      debugPrint("📢 Original Language Stored: $originalLanguage");

      // ✅ Change selected language to English on logout
      await userLanguagePreferenceBox.put("selectedLanguage", "English");

      // ✅ Retrieve stored language and user ID for debugging
      String storedLang = userLanguagePreferenceBox.get(
        "selectedLanguage",
        defaultValue: "English",
      );
      String storedUserId = userLanguagePreferenceBox.get(
        "userId",
        defaultValue: "NO UUID",
      );

      debugPrint("📢 Stored Language after logout: $storedLang");
      debugPrint("📢 Stored UserId: $storedUserId");

      // ✅ Dispatch event to update Firestore and Hive
      context.read<UpdateLanguagePreferenceBloc>().add(
        UpdateUserLanguagePreferenceEvent(
          uid: storedUserId,
          newLanguagePreference: "English",
        ),
      );

      // ✅ Open Hive box for user authentication status
      final userAuthBox = await Hive.openBox("userAuthStatusBox");
      await userAuthBox.put("userAuthStatus", false);
      debugPrint(
        "📢 User Auth Status after logout: ${userAuthBox.get("userAuthStatus")}",
      );

      // ✅ Set user language preference status to false
      await userLanguagePreferenceBox.put(
        "userLanguagePreferenceStatus",
        false,
      );
      debugPrint(
        "📢 User Language Preference Status: ${userLanguagePreferenceBox.get("userLanguagePreferenceStatus")}",
      );

      // ✅ Open Hive box for user onboarding status and set it to false
      final userOnBoardingBox = await Hive.openBox("userOnBoardingStatusBox");
      await userOnBoardingBox.put("userOnBoardingStatus", false);
      debugPrint(
        "📢 User Onboarding Status: ${userOnBoardingBox.get("userOnBoardingStatus")}",
      );
    }

    // Handle network failure
    void handleNetworkFailure(BuildContext context) {
      final networkState = context.read<NetworkBloc>().state;

      if (networkState is NetworkFailure) {
        SnackBarHelper.showSnackBar(
          context: context,
          message: appLocalization.internetFailureToast,
          backgroundColor: ColorName.toastErrorColor,
          textColor: ColorName.white,
          leadingIcon: Icons.signal_cellular_connected_no_internet_4_bar_sharp,
        );
      }
    }

    return MultiBlocProvider(
      providers: [
        // google auth bloc
        BlocProvider(create: (context) => locator.get<GoogleAuthBloc>()),

        // apple auth bloc
        BlocProvider(create: (context) => locator.get<AppleAuthBloc>()),

        // email auth bloc
        BlocProvider(create: (context) => locator.get<EmailBloc>()),

        // internet checker bloc
        BlocProvider(create: (context) => locator.get<NetworkBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          // google auth bloc
          BlocListener<GoogleAuthBloc, GoogleAuthState>(
            listener: (context, state) {
              if (state is GoogleAuthSignOutSuccess) {
                // Show success toast
                ToastHelper.showToast(
                  context: context,
                  message: appLocalization.authSignOutToastSuccess,
                  isSuccess: true,
                );

                // Navigate to the language preference screen
                GoRouter.of(context).pushReplacementNamed("userLangPreference");
              } else if (state is GoogleAuthFailure) {
                // Show failure toast
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
            listener: (context, state) {
              if (state is AppleAuthSignedOut) {
                // Show success toast
                ToastHelper.showToast(
                  context: context,
                  message: appLocalization.authSignOutToastSuccess,
                  isSuccess: true,
                );

                // language preference screen
                GoRouter.of(context).pushReplacementNamed("userLangPreference");
              } else if (state is AppleAuthFailure) {
                // failure toast helper
                ToastHelper.showToast(
                  context: context,
                  message: state.error,
                  isSuccess: false,
                );
              }
            },
          ),

          // email auth bloc
          BlocListener<EmailBloc, EmailState>(
            listener: (context, state) {
              if (state is EmailSignOutSuccess) {
                // Show success toast
                ToastHelper.showToast(
                  context: context,
                  message: appLocalization.authSignOutToastSuccess,
                  isSuccess: true,
                );

                // language preference screen
                GoRouter.of(context).pushReplacementNamed('userLangPreference');
              } else if (state is EmailSignOutFailure) {
                // show failure toast
                ToastHelper.showToast(
                  context: context,
                  message: state.error,
                  isSuccess: false,
                );
              }
            },
          ),

          // internet checker bloc
          BlocListener<NetworkBloc, NetworkState>(
            listener: (context, state) {
              if (state is NetworkFailure) {
                // no internet connection snack bar
                return SnackBarHelper.showSnackBar(
                  context: context,
                  message: appLocalization.internetFailureToast,
                  backgroundColor: ColorName.toastErrorColor,
                  textColor: ColorName.white,
                  leadingIcon:
                      Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                );
              } else if (state is NetworkSuccess) {
                //  internet connection snack bar
                return SnackBarHelper.showSnackBar(
                  context: context,
                  message: appLocalization.internetSuccessToast,
                  backgroundColor: ColorName.toastSuccessColor,
                  textColor: ColorName.white,
                  leadingIcon: Icons.signal_cellular_alt,
                );
              }
            },
          ),
        ],
        child: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: ColorName.profileBgColor,
                body: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// My account
                        Text(
                          textAlign: TextAlign.start,
                          appLocalization.myAccount,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(
                            color: ColorName.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: 20.h),

                        /// person profile img
                        BlocBuilder<
                          AuthCheckerProviderBloc,
                          AuthCheckerProviderState
                        >(
                          builder: (context, state) {
                            print("BlocBuilder State: $state");

                            if (state is AuthChecked) {
                              if (state.isEmailAuth) {
                                String userEmailFirstLetter =
                                    currentUserEmail.isNotEmpty
                                        ? currentUserEmail[0].toUpperCase()
                                        : "?";

                                return CustomEmailPersonAvatar(
                                  userEmailFirstLetter: userEmailFirstLetter,
                                );
                              } else if (state.isGoogleAuth) {
                                return CustomPersonAvatar(
                                  imageUrl:
                                      currentUser?.photoURL ??
                                      AppConstants.personPlaceHolder,
                                );
                              } else if (state.isAppleAuth) {
                                return CustomPersonAvatar(
                                  imageUrl:
                                      currentUser?.photoURL ??
                                      AppConstants.personPlaceHolder,
                                );
                              }
                            }

                            return SizedBox();
                          },
                        ),

                        SizedBox(height: 40.h),

                        BlocBuilder<
                          UpdateLanguagePreferenceBloc,
                          UpdateLanguagePreferenceState
                        >(
                          builder: (context, state) {
                            return Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.r),
                                    topRight: Radius.circular(25.r),
                                  ),
                                  color: ColorName.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 14.h,
                                  ),
                                  child: Column(
                                    children: [
                                      /// Scrollable content
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              /// personal info text
                                              Text(
                                                appLocalization.personalInfo,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall!.copyWith(
                                                  color: ColorName.primary,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13.sp,
                                                ),
                                              ),
                                              SizedBox(height: 20.h),

                                              // Name list tile (Only for Google/Apple Sign-In)
                                              BlocBuilder<
                                                AuthCheckerProviderBloc,
                                                AuthCheckerProviderState
                                              >(
                                                builder: (context, state) {
                                                  if (state is AuthChecked) {
                                                    if (state.isEmailAuth) {
                                                      return SizedBox();
                                                    } else if (state
                                                        .isAppleAuth) {
                                                      return CustomProfileListTile(
                                                        leadingIcon:
                                                            Icons
                                                                .person_outline,
                                                        title:
                                                            appLocalization
                                                                .yourName,
                                                        subtitle:
                                                            currentUserName,
                                                        showTrailing: false,
                                                      );
                                                    } else if (state
                                                        .isGoogleAuth) {
                                                      return CustomProfileListTile(
                                                        leadingIcon:
                                                            Icons
                                                                .person_outline,
                                                        title:
                                                            appLocalization
                                                                .yourName,
                                                        subtitle:
                                                            currentUserName,
                                                        showTrailing: false,
                                                      );
                                                    }
                                                  }

                                                  return SizedBox();
                                                },
                                              ),

                                              // Email list tile
                                              CustomProfileListTile(
                                                leadingIcon:
                                                    Icons.alternate_email,
                                                title:
                                                    appLocalization
                                                        .yourEmailAddress,
                                                subtitle: currentUserEmail,
                                                showTrailing: false,
                                              ),

                                              // Language preference list
                                              CustomProfileListTile(
                                                onTap: () {
                                                  // language preference settings screen
                                                  GoRouter.of(
                                                    context,
                                                  ).pushNamed(
                                                    "languagePreferenceSettings",
                                                  );
                                                },
                                                leadingIcon:
                                                    Icons.language_outlined,
                                                title:
                                                    appLocalization
                                                        .yourLanguage,
                                                subtitle:
                                                    appLocalization
                                                        .yourLanguageSubTitle,
                                              ),

                                              // Log out list tile
                                              BlocBuilder<
                                                AuthCheckerProviderBloc,
                                                AuthCheckerProviderState
                                              >(
                                                builder: (context, state) {
                                                  if (state is AuthChecked) {
                                                    void handleLogout(
                                                      VoidCallback logoutEvent,
                                                    ) {
                                                      handleNetworkFailure(
                                                        context,
                                                      );
                                                      logoutEvent();
                                                      handleUserLogout(context);
                                                    }

                                                    if (state.isEmailAuth) {
                                                      return CustomProfileListTile(
                                                        onTap:
                                                            () => handleLogout(
                                                              () {
                                                                context
                                                                    .read<
                                                                      EmailBloc
                                                                    >()
                                                                    .add(
                                                                      SignOutEvent(),
                                                                    );
                                                              },
                                                            ),
                                                        leadingIcon:
                                                            Icons
                                                                .logout_outlined,
                                                        title:
                                                            appLocalization
                                                                .logout,
                                                        subtitle:
                                                            appLocalization
                                                                .logoutSubTitle,
                                                      );
                                                    } else if (state
                                                        .isGoogleAuth) {
                                                      return CustomProfileListTile(
                                                        onTap:
                                                            () => handleLogout(() {
                                                              context
                                                                  .read<
                                                                    GoogleAuthBloc
                                                                  >()
                                                                  .add(
                                                                    GoogleAuthSignOutEvent(),
                                                                  );
                                                            }),
                                                        leadingIcon:
                                                            Icons
                                                                .logout_outlined,
                                                        title:
                                                            appLocalization
                                                                .logout,
                                                        subtitle:
                                                            appLocalization
                                                                .logoutSubTitle,
                                                      );
                                                    } else if (state
                                                        .isAppleAuth) {
                                                      return CustomProfileListTile(
                                                        onTap:
                                                            () => handleLogout(() {
                                                              context
                                                                  .read<
                                                                    AppleAuthBloc
                                                                  >()
                                                                  .add(
                                                                    AppleSignOutRequested(),
                                                                  );
                                                            }),
                                                        leadingIcon:
                                                            Icons
                                                                .logout_outlined,
                                                        title:
                                                            appLocalization
                                                                .logout,
                                                        subtitle:
                                                            appLocalization
                                                                .logoutSubTitle,
                                                      );
                                                    }
                                                  }
                                                  return SizedBox();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      /// Thanks section
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        child: CustomProfileThanksText(
                                          developerName: appLocalization.imran,
                                          developerPortfolio:
                                              "https://linktr.ee/Imran_B",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
