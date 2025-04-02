import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:taskapp/commons/widgets/custom_alert_dialog.dart';
import 'package:taskapp/commons/widgets/custom_icon_filled_btn.dart';
import 'package:taskapp/core/helper/toast_helper.dart';
import 'package:taskapp/features/bottom_nav/view_modal/bottom_nav_bloc.dart';
import 'package:taskapp/features/language_preference/view_modal/lang_pref_bloc/language_preference_bloc.dart';
import 'package:taskapp/features/language_preference/widgets/custom_lang_preference_List_tile.dart';
import 'package:taskapp/features/language_preference_settings/view_modals/update_lang_preference_bloc/update_language_preference_bloc.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class LanguagePreferenceSettingsScreen extends StatelessWidget {
  const LanguagePreferenceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return BlocListener<
      UpdateLanguagePreferenceBloc,
      UpdateLanguagePreferenceState
    >(
      listener: (context, state) {
        if (state is UpdateLanguagePreferenceSuccess) {
          // success toast
          ToastHelper.showToast(
            context: context,
            message: appLocalization.updateLanguagePreferenceSuccessToast,
            isSuccess: true,
          );

          if (context.mounted) {
            GoRouter.of(context).pop(); // Close dialog

            /// Navigate to Profile Screen (Index 4)
            context.read<BottomNavBloc>().add(SelectTab(index: 4));

            debugPrint("Navigating to Profile Screen...");
          }
        } else if (state is UpdateLanguagePreferenceFailure) {
          // failure toast
          ToastHelper.showToast(
            context: context,
            message: appLocalization.updateLanguagePreferenceFailureToast,
            isSuccess: false,
          );

          /// Close the dialog
          GoRouter.of(context).pop();
        }
      },
      child: SafeArea(
        child: Scaffold(
          // confirm language btn
          bottomSheet: BlocBuilder<
            LanguagePreferenceBloc,
            LanguagePreferenceState
          >(
            builder: (context, state) {
              // selected language
              String? selectedLanguage;
              if (state is LangPreferenceSelected) {
                selectedLanguage = state.selectedLanguage;
              }

              return BlocBuilder<
                UpdateLanguagePreferenceBloc,
                UpdateLanguagePreferenceState
              >(
                builder: (context, updateState) {
                  return Container(
                    height: 80.h,
                    decoration: BoxDecoration(color: ColorName.white),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CustomIconFilledBtn(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomAlertDialog(
                                  alertTitle:
                                      appLocalization
                                          .changeLanguagePreferenceAlertDialogTitle,
                                  alertSubTitle:
                                      appLocalization
                                          .changeLanguagePreferenceAlertDialogSubTitle,
                                  alertIcon: Assets.icon.svg.languagePreference,
                                  onCancelTap: () {
                                    GoRouter.of(context).pop();
                                  },
                                  onConfirmTap: () async {
                                    if (selectedLanguage == null) {
                                      ToastHelper.showToast(
                                        context: context,
                                        message:
                                            appLocalization
                                                .languagePreferenceSettingFailureToast,
                                        isSuccess: false,
                                      );
                                      return;
                                    }

                                    /// Open Hive box and store the selected language
                                    final box = await Hive.openBox(
                                      "userLanguagePreferenceBox",
                                    );
                                    await box.put(
                                      "selectedLanguage",
                                      selectedLanguage,
                                    );
                                    String? storedLang = box.get(
                                      "selectedLanguage",
                                    );
                                    String storedUserId = box.get("userId");

                                    debugPrint("Stored Language: $storedLang");
                                    debugPrint("Stored UserId: $storedUserId");

                                    /// Dispatch event to update Firestore
                                    context
                                        .read<UpdateLanguagePreferenceBloc>()
                                        .add(
                                          UpdateUserLanguagePreferenceEvent(
                                            uid: storedUserId,
                                            newLanguagePreference:
                                                selectedLanguage,
                                          ),
                                        );

                                    /// Wait a short delay to ensure Firestore updates
                                    await Future.delayed(Duration(seconds: 1));
                                  },
                                  cancelText: appLocalization.cancelDialogText,
                                  confirmText:
                                      appLocalization.confirmDialogText,
                                );
                              },
                            );
                          },
                          btnTitle: appLocalization.continueLanguage,
                          iconPath: Assets.icon.svg.languagePreference,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),

          appBar: AppBar(
            centerTitle: true,
            // leading icon
            leading: BlocBuilder<
              LanguagePreferenceBloc,
              LanguagePreferenceState
            >(
              builder: (context, state) {
                // Retrieve selected language
                String? selectedLanguage;
                if (state is LangPreferenceSelected) {
                  selectedLanguage = state.selectedLanguage;
                }

                return IconButton(
                  onPressed: () async {
                    // Open Hive box
                    final box = await Hive.openBox("userLanguagePreferenceBox");

                    // Retrieve stored language from Hive
                    String? storedLanguage = box.get("selectedLanguage");

                    if (selectedLanguage == null && storedLanguage == null) {
                      // Show error if no language is selected
                      ToastHelper.showToast(
                        context: context,
                        message:
                            appLocalization
                                .languagePreferenceSettingFailureToast,
                        isSuccess: false,
                      );
                      return;
                    }

                    // Allow back navigation only if language is selected or stored
                    GoRouter.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: ColorName.primary,
                  ),
                );
              },
            ),

            // title
            title: Text(appLocalization.languagePreferenceSettingsAppBarTitle),
            // title style
            titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: ColorName.primary,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: BlocBuilder<LanguagePreferenceBloc, LanguagePreferenceState>(
              builder: (context, state) {
                String? selectedLanguage;
                if (state is LangPreferenceSelected) {
                  selectedLanguage = state.selectedLanguage;
                }

                return Column(
                  spacing: 12.h,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Subtitle of language preference settings
                    Text(
                      textAlign: TextAlign.center,
                      appLocalization.languagePreferenceSettingsSubTitle,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorName.grey,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
