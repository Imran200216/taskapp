import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:taskapp/commons/widgets/custom_date_picker_text_field.dart';
import 'package:taskapp/commons/widgets/custom_description_text_area.dart';
import 'package:taskapp/commons/widgets/custom_icon_filled_btn.dart';
import 'package:taskapp/commons/widgets/custom_long_drop_down_text_field.dart';
import 'package:taskapp/commons/widgets/custom_text_field.dart';
import 'package:taskapp/core/bloc/network_checker_bloc/network_bloc.dart';
import 'package:taskapp/core/helper/snack_bar_helper.dart';
import 'package:taskapp/core/helper/toast_helper.dart';
import 'package:taskapp/core/locator/service_locator.dart';
import 'package:taskapp/core/validator/app_validator.dart';
import 'package:taskapp/features/add_task/view_modals/add_task_bloc/add_task_bloc.dart';
import 'package:taskapp/features/bottom_nav/view_modal/bottom_nav_bloc.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // form key
  final formKey = GlobalKey<FormState>();

  // text editing controller
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController dateRangeController = TextEditingController();

  // task data
  String? dateRange;
  String? taskStatus;
  String? taskPriority;

  /// Notification on and off text field
  bool notificationAlert = false;

  // clear task
  void _clearTaskData() {
    taskNameController.clear();
    taskDescriptionController.clear();
    dateRangeController.clear();
    dateRange = null;
    taskStatus = null;
    taskPriority = null;
    notificationAlert = false;
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    dateRangeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return MultiBlocProvider(
      providers: [
        // add task bloc
        BlocProvider(create: (context) => locator.get<AddTaskBloc>()),

        // internet checker bloc
        BlocProvider(create: (context) => locator.get<NetworkBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          // add task bloc
          BlocListener<AddTaskBloc, AddTaskState>(
            listener: (context, state) {
              if (state is AddTaskSuccess) {
                // Success toast
                ToastHelper.showToast(
                  context: context,
                  message: appLocalization.addTaskToastSuccess,
                  isSuccess: true,
                );

                // home screen
                context.read<BottomNavBloc>().add(SelectTab(index: 0));

                // clear all task data
              } else if (state is AddTaskFailure) {
                // Failure toast
                ToastHelper.showToast(
                  context: context,
                  message: appLocalization.addTaskToastFailure,
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
                                      (value) => AppValidator.validateTaskName(
                                        context,
                                        value,
                                      ),
                                  prefixIcon: Icons.task_alt,
                                  hasBorder: true,
                                ),

                                /// Task description text field
                                CustomDescriptionTextArea(
                                  textEditingController:
                                      taskDescriptionController,
                                  validator:
                                      (value) =>
                                          AppValidator.validateTaskDescription(
                                            context,
                                            value,
                                          ),
                                  hintText:
                                      appLocalization.taskDescriptionHintText,
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
                                    // Set the picked date range to both controller and variable
                                    dateRange = value;
                                    dateRangeController.text = value;
                                  },
                                  hasBorder: true,
                                ),

                                /// notification on and off text field
                                CustomDropDownTextField(
                                  validator:
                                      (value) =>
                                          AppValidator.validateNotificationAlert(
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
                                  onChanged: (value) {
                                    notificationAlert =
                                        (value ==
                                            appLocalization.notificationOn);
                                  },
                                ),

                                /// Task Status Dropdown
                                CustomDropDownTextField(
                                  validator:
                                      (value) =>
                                          AppValidator.validateTaskStatus(
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
                                    taskStatus = value;
                                  },
                                ),

                                /// Task Priority Dropdown
                                CustomDropDownTextField(
                                  validator:
                                      (value) =>
                                          AppValidator.validateTaskPriority(
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
                                  selectedValue:
                                      appLocalization.taskPriorityHigh,
                                  onChanged: (value) {
                                    taskPriority = value;
                                  },
                                ),

                                SizedBox(height: 12.h),

                                // Add Task Button
                                BlocBuilder<AddTaskBloc, AddTaskState>(
                                  builder: (context, state) {
                                    return CustomIconFilledBtn(
                                      isLoading: state is AddTaskLoading,
                                      onTap: () async {
                                        // network state
                                        final networkState =
                                            context.read<NetworkBloc>().state;

                                        if (networkState is NetworkFailure) {
                                          // error toast
                                          SnackBarHelper.showSnackBar(
                                            context: context,
                                            message:
                                                appLocalization
                                                    .internetFailureToast,
                                            backgroundColor:
                                                ColorName.toastErrorColor,
                                            textColor: ColorName.white,
                                            leadingIcon:
                                                Icons
                                                    .signal_cellular_connected_no_internet_4_bar_sharp,
                                          );

                                          return;
                                        }

                                        // form validation
                                        if (formKey.currentState!.validate()) {
                                          /// Generating the UUID
                                          const uuid = Uuid();
                                          String taskId = uuid.v4();

                                          // Open the Hive box for user preferences
                                          final box = await Hive.openBox(
                                            "userLanguagePreferenceBox",
                                          );

                                          // Retrieve the stored user UID
                                          String storedUserId = box.get(
                                            "userId",
                                          );

                                          // ✅ Ensure `dateRange` is not null
                                          if (dateRange == null ||
                                              !dateRange!.contains(" - ")) {
                                            print("Invalid or null date range");
                                            return;
                                          }

                                          List<DateTime> dateRangeList = [];
                                          try {
                                            dateRangeList =
                                                dateRange!
                                                    .split(
                                                      " - ",
                                                    ) // ✅ Correctly split by " - "
                                                    .map(
                                                      (date) => DateTime.parse(
                                                        date.trim(),
                                                      ),
                                                    ) // ✅ Parse each date
                                                    .toList();
                                          } catch (e) {
                                            print(
                                              "Error parsing date range: $e",
                                            );
                                            return;
                                          }

                                          // Dispatch the event to the Bloc
                                          context.read<AddTaskBloc>().add(
                                            AddTask(
                                              taskId: taskId,
                                              userUid: storedUserId,
                                              taskName:
                                                  taskNameController.text
                                                      .trim(),
                                              taskDescription:
                                                  taskDescriptionController.text
                                                      .trim(),
                                              dateRange: dateRangeList,
                                              // ✅ Correctly formatted List<DateTime>
                                              notificationAlert:
                                                  notificationAlert,
                                              taskStatus: taskStatus!,
                                              taskPriority: taskPriority!,
                                              context: context,
                                            ),
                                          );

                                          // Clear all task data
                                          _clearTaskData();
                                        }
                                      },
                                      btnTitle: appLocalization.addTask,
                                      iconPath: Assets.icon.svg.login,
                                    );
                                  },
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
          },
        ),
      ),
    );
  }
}
