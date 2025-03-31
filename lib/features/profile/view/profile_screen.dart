import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/core/constants/app_constants.dart';
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
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorName.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 20.h),

                /// person profile img
                BlocBuilder<AuthCheckerProviderBloc, AuthCheckerProviderState>(
                  builder: (context, state) {
                    print("BlocBuilder State: $state"); // Debug log

                    if (state is AuthChecked && state.isEmailAuth) {
                      String userEmailFirstLetter =
                          currentUserEmail.isNotEmpty
                              ? currentUserEmail[0].toUpperCase()
                              : "?";

                      return CustomEmailPersonAvatar(
                        userEmailFirstLetter: userEmailFirstLetter,
                      );
                    } else {
                      return CustomPersonAvatar(
                        imageUrl:
                            currentUser?.photoURL ??
                            AppConstants.personPlaceHolder,
                      );
                    }
                  },
                ),

                SizedBox(height: 40.h),

                Expanded(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                      if (state is AuthChecked &&
                                          state.isEmailAuth) {
                                        return SizedBox();
                                      } else {
                                        return CustomProfileListTile(
                                          leadingIcon: Icons.person_outline,
                                          title: appLocalization.yourName,
                                          subtitle: currentUserName,
                                          showTrailing: false,
                                        );
                                      }
                                    },
                                  ),

                                  // Email list tile
                                  CustomProfileListTile(
                                    leadingIcon: Icons.alternate_email,
                                    title: appLocalization.yourEmailAddress,
                                    subtitle: currentUserEmail,
                                    showTrailing: false,
                                  ),

                                  // App info tile
                                  CustomProfileListTile(
                                    onTap: () {
                                      // app info settings screen
                                      GoRouter.of(
                                        context,
                                      ).pushNamed("appInfoSettings");
                                    },
                                    leadingIcon: Icons.info_outline_rounded,
                                    title: appLocalization.appInfo,
                                    subtitle:
                                        appLocalization
                                            .taskNotifyAppInfoDescription,
                                  ),

                                  // Language preference list
                                  CustomProfileListTile(
                                    onTap: () {
                                      // language preference settings screen
                                      GoRouter.of(
                                        context,
                                      ).pushNamed("languagePreferenceSettings");
                                    },
                                    leadingIcon: Icons.language_outlined,
                                    title: appLocalization.yourLanguage,
                                    subtitle:
                                        appLocalization.yourLanguageSubTitle,
                                  ),

                                  // Log out list tile
                                  CustomProfileListTile(
                                    onTap: () {},
                                    leadingIcon: Icons.logout_outlined,
                                    title: appLocalization.logout,
                                    subtitle: appLocalization.logoutSubTitle,
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
                              developerPortfolio: "https://linktr.ee/Imran_B",
                            ),
                          ),
                        ],
                      ),
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
