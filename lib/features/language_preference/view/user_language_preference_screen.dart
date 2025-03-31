import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:taskapp/commons/widgets/custom_icon_filled_btn.dart';
import 'package:taskapp/core/helper/toast_helper.dart';
import 'package:taskapp/features/language_preference/view_modal/lang_pref_bloc/language_preference_bloc.dart';
import 'package:taskapp/features/language_preference/widgets/custom_lang_preference_List_tile.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class UserLanguagePreferenceScreen extends StatelessWidget {
  const UserLanguagePreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return SafeArea(
      child: Scaffold(
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

              /// app version text
              BlocBuilder<LanguagePreferenceBloc, LanguagePreferenceState>(
                builder: (context, state) {
                  String? selectedLanguage;
                  if (state is LangPreferenceSelected) {
                    selectedLanguage = state.selectedLanguage;
                  }

                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Welcome text
                        Text(
                          appLocalization.authTitle,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium!.copyWith(
                            color: ColorName.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),

                        SizedBox(height: 12.h),

                        // Choose your language
                        Text(
                          appLocalization.userLanguagePreferenceSubTitle,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium!.copyWith(
                            color: ColorName.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                          ),
                        ),

                        SizedBox(height: 30.h),

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 80.w),
                          child: Column(
                            spacing: 12.h,
                            children: [
                              /// tamil list tile
                              CustomLangPreferenceListTile(
                                title: appLocalization.tamil,
                                isChecked: selectedLanguage == "Tamil",
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    context.read<LanguagePreferenceBloc>().add(
                                      ToggleLanguage(language: "Tamil"),
                                    );
                                  }
                                },
                              ),

                              /// english list tile
                              CustomLangPreferenceListTile(
                                title: appLocalization.english,
                                isChecked: selectedLanguage == "English",
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    context.read<LanguagePreferenceBloc>().add(
                                      ToggleLanguage(language: "English"),
                                    );
                                  }
                                },
                              ),

                              /// hindi list tile
                              CustomLangPreferenceListTile(
                                title: appLocalization.hindi,
                                isChecked: selectedLanguage == "Hindi",
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    context.read<LanguagePreferenceBloc>().add(
                                      ToggleLanguage(language: "Hindi"),
                                    );
                                  }
                                },
                              ),

                              /// arabic list tile
                              CustomLangPreferenceListTile(
                                title: appLocalization.arabic,
                                isChecked: selectedLanguage == "Arabic",
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    context.read<LanguagePreferenceBloc>().add(
                                      ToggleLanguage(language: "Arabic"),
                                    );
                                  }
                                },
                              ),

                              /// french list tile
                              CustomLangPreferenceListTile(
                                title: appLocalization.french,
                                isChecked: selectedLanguage == "French",
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    context.read<LanguagePreferenceBloc>().add(
                                      ToggleLanguage(language: "French"),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 30.h),

                        // Choose your language
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 44.w),
                          child: Text(
                            textAlign: TextAlign.center,
                            appLocalization.userLanguagePreferenceSettings,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineMedium!.copyWith(
                              color: ColorName.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),

                        // continue btn
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 44.w),
                          child: CustomIconFilledBtn(
                            onTap: () async {
                              if (selectedLanguage == null) {
                                // Show error if no language is selected
                                ToastHelper.showToast(
                                  context: context,
                                  message:
                                      appLocalization
                                          .languagePreferenceFailureToast,
                                  isSuccess: false,
                                );
                                return;
                              }

                              /// Generating the UUID
                              const uuid = Uuid();
                              String userId = uuid.v4();

                              /// Open the Hive box and store values
                              final box = await Hive.openBox(
                                "userLanguagePreferenceBox",
                              );
                              await box.put(
                                "selectedLanguage",
                                selectedLanguage,
                              );
                              await box.put("userId", userId);
                              await box.put(
                                "userLanguagePreferenceStatus",
                                true,
                              ); // Default is false

                              /// Retrieve and print stored data
                              String storedLang = box.get("selectedLanguage");
                              String storedUserId = box.get("userId");
                              bool storedStatus = box.get(
                                "userLanguagePreferenceStatus",
                              );

                              print(
                                "=========== Stored Language: $storedLang =========",
                              );
                              print(
                                "=========== Stored User ID: $storedUserId =========",
                              );
                              print(
                                "=========== Language Preference Status: $storedStatus =========",
                              );

                              // Show success toast
                              ToastHelper.showToast(
                                context: context,
                                message:
                                    appLocalization
                                        .languagePreferenceSuccessToast,
                                isSuccess: true,
                              );

                              // Navigate to Onboarding Screen
                              GoRouter.of(
                                context,
                              ).pushReplacementNamed("onBoarding");
                            },
                            btnTitle: appLocalization.continueText,
                            iconPath: Assets.icon.svg.login,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
