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
import 'package:uuid/uuid.dart';

class UserLanguagePreferenceScreen extends StatelessWidget {
  const UserLanguagePreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                          "Welcome to Tasify",
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
                          "Choose your language",
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
                                title: "Tamil",
                                isChecked: selectedLanguage == "Tamil",
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    context.read<LanguagePreferenceBloc>().add(
                                      const ToggleLanguage(language: "Tamil"),
                                    );
                                  }
                                },
                              ),

                              /// english list tile
                              CustomLangPreferenceListTile(
                                title: "English",
                                isChecked: selectedLanguage == "English",
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    context.read<LanguagePreferenceBloc>().add(
                                      const ToggleLanguage(language: "English"),
                                    );
                                  }
                                },
                              ),

                              /// tamil list tile
                              CustomLangPreferenceListTile(
                                title: "Arabic",
                                isChecked: selectedLanguage == "Arabic",
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    context.read<LanguagePreferenceBloc>().add(
                                      const ToggleLanguage(language: "Arabic"),
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
                            "Your language preference can be changed at any time in Settings.",
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
                                      "Please select a language before continuing.",
                                  isSuccess: false,
                                );
                                return;
                              }

                              /// generating the uuid
                              const uuid = Uuid();
                              String userId = uuid.v4();

                              /// store the user selected lang (String)
                              final box = await Hive.openBox(
                                "userLanguagePreferenceBox",
                              );
                              await box.put(
                                "selectedLanguage",
                                selectedLanguage,
                              );
                              await box.put("userId", userId);

                              /// Retrieve and print stored data
                              String storedLang = box.get("selectedLanguage");
                              String storedUserId = box.get("userId");

                              print(
                                "=========== Stored Language: $storedLang =========",
                              );
                              print(
                                "=========== Stored User ID: $storedUserId =========",
                              );

                              // Show success toast
                              ToastHelper.showToast(
                                context: context,
                                message:
                                    "Language preference saved successfully!",
                                isSuccess: true,
                              );

                              // auth screen
                              GoRouter.of(context).pushReplacementNamed("auth");
                            },
                            btnTitle: "Continue",
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
