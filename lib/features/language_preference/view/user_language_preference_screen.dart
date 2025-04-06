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

class UserLanguagePreferenceScreen extends StatefulWidget {
  const UserLanguagePreferenceScreen({super.key});

  @override
  State<UserLanguagePreferenceScreen> createState() =>
      _UserLanguagePreferenceScreenState();
}

class _UserLanguagePreferenceScreenState
    extends State<UserLanguagePreferenceScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LanguagePreferenceBloc>().add(LoadLanguagePreference());
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: ColorName.white,
          child: Stack(
            children: [
              // Top decoration
              Positioned(
                top: -130,
                left: -130,
                child: ClipRect(
                  child: SvgPicture.asset(
                    Assets.img.svg.decorationTop,
                    height: 240.h,
                    color: ColorName.primary,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Bottom decoration
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

              BlocConsumer<LanguagePreferenceBloc, LanguagePreferenceState>(
                listener: (context, state) {
                  if (state is LanguagePreferenceFailure) {
                    ToastHelper.showToast(
                      context: context,
                      message: appLocalization.languagePreferenceFailureToast,
                      isSuccess: false,
                    );
                  }
                },
                builder: (context, state) {
                  final selectedLang =
                      state is LangPreferenceSelected
                          ? state.selectedLanguage
                          : null;

                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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

                        // Language list
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 80.w),
                          child: Column(
                            children: [
                              CustomLangPreferenceListTile(
                                title: appLocalization.tamil,
                                isChecked: selectedLang == "Tamil",
                                onChanged: (val) {
                                  if (val == true) {
                                    context.read<LanguagePreferenceBloc>().add(
                                      ToggleLanguage(language: "Tamil"),
                                    );
                                  }
                                },
                              ),
                              CustomLangPreferenceListTile(
                                title: appLocalization.english,
                                isChecked: selectedLang == "English",
                                onChanged: (val) {
                                  if (val == true) {
                                    context.read<LanguagePreferenceBloc>().add(
                                      ToggleLanguage(language: "English"),
                                    );
                                  }
                                },
                              ),
                              CustomLangPreferenceListTile(
                                title: appLocalization.hindi,
                                isChecked: selectedLang == "Hindi",
                                onChanged: (val) {
                                  if (val == true) {
                                    context.read<LanguagePreferenceBloc>().add(
                                      ToggleLanguage(language: "Hindi"),
                                    );
                                  }
                                },
                              ),
                              CustomLangPreferenceListTile(
                                title: appLocalization.arabic,
                                isChecked: selectedLang == "Arabic",
                                onChanged: (val) {
                                  if (val == true) {
                                    context.read<LanguagePreferenceBloc>().add(
                                      ToggleLanguage(language: "Arabic"),
                                    );
                                  }
                                },
                              ),
                              CustomLangPreferenceListTile(
                                title: appLocalization.french,
                                isChecked: selectedLang == "French",
                                onChanged: (val) {
                                  if (val == true) {
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

                        // Info text
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 44.w),
                          child: Text(
                            appLocalization.userLanguagePreferenceSettings,
                            textAlign: TextAlign.center,
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

                        // Continue button
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 44.w),
                          child: CustomIconFilledBtn(
                            onTap: () async {
                              if (selectedLang == null) {
                                context.read<LanguagePreferenceBloc>().add(
                                  LanguagePreferenceValidationFailed(),
                                );
                                // Add a small delay to ensure the toast appears
                                await Future.delayed(
                                  Duration(milliseconds: 100),
                                );
                                return;
                              }

                              // This code should only run if a language is selected
                              final box = await Hive.openBox(
                                "userLanguagePreferenceBox",
                              );
                              final userId = const Uuid().v4();
                              await box.put("userId", userId);
                              await box.put(
                                "userLanguagePreferenceStatus",
                                true,
                              );

                              ToastHelper.showToast(
                                context: context,
                                message:
                                    appLocalization
                                        .languagePreferenceSuccessToast,
                                isSuccess: true,
                              );

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
