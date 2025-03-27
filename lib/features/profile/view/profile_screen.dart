import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/features/profile/widgets/custom_person_avatar.dart';
import 'package:taskapp/features/profile/widgets/custom_profile_list_tile.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

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
                CustomPersonAvatar(
                  size: 120,
                  imageUrl:
                      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=1288&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 14.h,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /// personal info text
                            Text(
                              textAlign: TextAlign.start,
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

                            // name list tile
                            CustomProfileListTile(
                              onTap: () {},
                              leadingIcon: Icons.person_outline,
                              title: appLocalization.yourName,
                              subtitle: "Marie Gwen",
                            ),

                            // email list tile
                            CustomProfileListTile(
                              onTap: () {},
                              leadingIcon: Icons.alternate_email,
                              title: appLocalization.yourEmailAddress,
                              subtitle: "MarieGwen@gmail.com",
                            ),

                            // app info tile
                            CustomProfileListTile(
                              onTap: () {},
                              leadingIcon: Icons.info_outline_rounded,
                              title: appLocalization.appInfo,
                              subtitle:
                                  appLocalization.taskNotifyAppInfoDescription,
                            ),

                            // dev info tile
                            CustomProfileListTile(
                              onTap: () {},
                              leadingIcon: Icons.developer_mode,
                              title: appLocalization.devInfo,
                              subtitle: appLocalization.devInfoSubTitle,
                            ),

                            // language preference list
                            CustomProfileListTile(
                              onTap: () {},
                              leadingIcon: Icons.language_outlined,
                              title: appLocalization.yourLanguage,
                              subtitle: appLocalization.yourLanguageSubTitle,
                            ),

                            // log out list tile
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
