import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskapp/commons/widgets/custom_date_picker_text_field.dart';
import 'package:taskapp/commons/widgets/custom_description_text_area.dart';
import 'package:taskapp/commons/widgets/custom_drop_down_text_field.dart';
import 'package:taskapp/commons/widgets/custom_text_field.dart';
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

    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                        hintText: appLocalization.taskNameHintText,
                        prefixIcon: Icons.task_alt,
                        hasBorder: true,
                      ),

                      /// Task description text field
                      CustomDescriptionTextArea(
                        hintText: "Task Description",
                        prefixIcon: Icons.description_outlined,
                        maxLines: 5,
                      ),

                      /// Task duration of start and end
                      CustomDateRangePickerTextField(
                        hintText: "Pick a date range",
                        prefixIcon: Icons.timelapse_outlined,
                        onChanged: (value) {
                          print("Selected Date Range: $value");
                        },
                        hasBorder: true,
                      ),

                      /// notification on and off text field
                      CustomDropdownTextField<String>(
                        hasBorder: true,
                        hintText: "Select an option",
                        prefixIcon: Icons.notifications_on_outlined,
                        items: ["Notification On", "Notificaiton Off"],
                        itemLabel: (value) => value,
                        selectedValue: "Notification On",
                        onChanged: (value) {
                          print("Selected: $value");
                        },
                      ),

                      /// Task Urgency drop down text field
                      SizedBox(
                        height: 80.h,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomDropdownTextField<String>(
                                hasBorder: true,
                                hintText: "Select an Task Urgency",
                                prefixIcon: Icons.notifications_on_outlined,
                                items: [
                                  "Urgent (Immediate attention)",
                                  "High Priority (Important but not immediate)",
                                  "Normal (Routine work)",
                                  "Low Priority (Can be done later)",
                                ],
                                itemLabel: (value) => value,
                                selectedValue: "Urgent (Immediate attention)",
                                onChanged: (value) {
                                  print("Selected: $value");
                                },
                              ),
                            ),
                          ],
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
    );
  }
}
