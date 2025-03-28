import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskapp/commons/widgets/custom_date_picker_text_field.dart';
import 'package:taskapp/commons/widgets/custom_description_text_area.dart';
import 'package:taskapp/commons/widgets/custom_icon_filled_btn.dart';
import 'package:taskapp/commons/widgets/custom_long_drop_down_text_field.dart';
import 'package:taskapp/commons/widgets/custom_text_field.dart';
import 'package:taskapp/core/helper/toast_helper.dart';
import 'package:taskapp/core/validator/app_validator.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    // form key
    final formKey = GlobalKey<FormState>();

    // text editing controller
    final TextEditingController taskNameController = TextEditingController();
    final TextEditingController taskDescriptionController =
        TextEditingController();
    final TextEditingController dateRangeController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Stack(
            children: [
              // top decoration
              Positioned(
                top: -130,
                right: -130,
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
                left: -130,
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

              Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      spacing: 15.h,
                      children: [
                        /// task img
                        SvgPicture.asset(
                          Assets.img.svg.addTask,
                          height: 0.4.sh,
                          fit: BoxFit.cover,
                        ),

                        /// Task name text field
                        CustomTextField(
                          textEditingController: taskNameController,
                          hintText: appLocalization.taskNameHintText,
                          validator:
                              (value) =>
                                  AppValidator.validateTaskName(context, value),
                          prefixIcon: Icons.task_alt,
                          hasBorder: true,
                        ),

                        /// Task description text field
                        CustomDescriptionTextArea(
                          textEditingController: taskDescriptionController,
                          validator:
                              (value) => AppValidator.validateTaskDescription(
                                context,
                                value,
                              ),
                          hintText: appLocalization.taskDescriptionHintText,
                          prefixIcon: Icons.description_outlined,
                          maxLines: 5,
                        ),

                        /// Task duration of start and end
                        CustomDateRangePickerTextField(
                          textEditingController: dateRangeController,
                          validator:
                              (value) => AppValidator.validateDateRange(
                                context,
                                value,
                              ),
                          hintText: appLocalization.dataRange,
                          prefixIcon: Icons.timelapse_outlined,
                          onChanged: (value) {
                            print("Selected Date Range: $value");
                          },
                          hasBorder: true,
                        ),

                        /// notification on and off text field
                        CustomDropDownTextField(
                          validator:
                              (value) => AppValidator.validateNotificationAlert(
                                context,
                                value,
                              ),
                          hasBorder: true,
                          hintText: appLocalization.notificationAlert,
                          prefixIcon: Icons.notifications_on_outlined,
                          items: [
                            appLocalization.notificationOn,
                            appLocalization.notificationOff,
                          ],
                        ),

                        /// Task status
                        CustomDropDownTextField(
                          validator:
                              (value) => AppValidator.validateTaskStatus(
                                context,
                                value,
                              ),
                          hintText: appLocalization.taskStatus,
                          prefixIcon: Icons.task_alt,
                          hasBorder: true,
                          items: [
                            appLocalization.pendingStatus,
                            appLocalization.inProgressStatus,
                            appLocalization.completedStatus,
                            appLocalization.overDueStatus,
                          ],
                          selectedValue: appLocalization.pendingStatus,
                          onChanged: (value) {
                            print("Selected: $value");
                          },
                        ),

                        /// Task priority
                        CustomDropDownTextField(
                          validator:
                              (value) => AppValidator.validateTaskPriority(
                                context,
                                value,
                              ),
                          hintText: appLocalization.taskPriority,
                          prefixIcon: Icons.timeline_outlined,
                          hasBorder: true,
                          items: [
                            appLocalization.taskPriorityHigh,
                            appLocalization.taskPriorityMedium,
                            appLocalization.taskPriorityLow,
                          ],
                          selectedValue: appLocalization.taskPriorityHigh,
                          onChanged: (value) {
                            print("Selected: $value");
                          },
                        ),

                        SizedBox(height: 12.h),

                        CustomIconFilledBtn(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                            } else {
                              ToastHelper.showToast(
                                context: context,
                                message: "Fill all the details",
                                isSuccess: false,
                              );
                            }
                          },
                          btnTitle: appLocalization.addTask,
                          iconPath: Assets.icon.svg.login,
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
    );
  }
}
