import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskapp/core/bloc/network_checker_bloc/network_bloc.dart';
import 'package:taskapp/core/helper/snack_bar_helper.dart';
import 'package:taskapp/core/locator/service_locator.dart';
import 'package:taskapp/features/archive/widgets/custom_no_task_found.dart';
import 'package:taskapp/features/home/view_modals/selection_chip_bloc/selection_chip_bloc.dart';
import 'package:taskapp/features/home/view_modals/view_task_bloc/view_task_bloc.dart';
import 'package:taskapp/features/home/widgets/custom_choice_chip.dart';
import 'package:taskapp/features/home/widgets/custom_task_list_tile.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';
import 'dart:ui' as lang;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);
    final isRTL = Directionality.of(context) == lang.TextDirection.rtl;

    return MultiBlocProvider(
      providers: [
        // Selection chip bloc
        BlocProvider(create: (context) => locator.get<SelectionChipBloc>()),

        // Network checker bloc
        BlocProvider(create: (context) => locator.get<NetworkBloc>()),

        // View task bloc with initial fetch
        BlocProvider(
          create:
              (context) => locator.get<ViewTaskBloc>()..add(FetchUserTasks()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          // Listen for internet status changes
          BlocListener<NetworkBloc, NetworkState>(
            listener: (context, state) {
              if (state is NetworkFailure) {
                SnackBarHelper.showSnackBar(
                  context: context,
                  message: appLocalization.internetFailureToast,
                  backgroundColor: ColorName.toastErrorColor,
                  textColor: ColorName.white,
                  leadingIcon:
                      Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                );
              } else if (state is NetworkSuccess) {
                SnackBarHelper.showSnackBar(
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
        child: SafeArea(
          child: Directionality(
            textDirection:
                isRTL ? lang.TextDirection.rtl : lang.TextDirection.ltr,
            child: Scaffold(
              backgroundColor: ColorName.white,
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 20.w,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        isRTL
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      // Greeting section
                      Align(
                        alignment:
                            isRTL
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment:
                              isRTL
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${appLocalization.hello} Imran B!",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(
                                color: ColorName.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              ),
                            ),
                            Text(
                              appLocalization.haveANiceDay,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall!.copyWith(
                                color: ColorName.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Choice chips for task filter
                      BlocBuilder<SelectionChipBloc, SelectionChipState>(
                        builder: (context, state) {
                          final options = [
                            appLocalization.chipTaskCompleted,
                            appLocalization.chipTaskInProgress,
                            appLocalization.chipTaskOverDue,
                          ];
                          int selectedIndex =
                              (state is SelectionChipSelected)
                                  ? state.selectedIndex
                                  : 0;

                          return Align(
                            alignment:
                                isRTL
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Wrap(
                              spacing: 10.w,
                              children: List.generate(options.length, (index) {
                                final isSelected = selectedIndex == index;
                                return CustomChoiceChip(
                                  index: index,
                                  label: options[index],
                                  isSelected: isSelected,
                                  onSelected: (_) {
                                    context.read<SelectionChipBloc>().add(
                                      SelectChipEvent(index),
                                    );
                                  },
                                );
                              }),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 20.h),

                      // Task list
                      BlocBuilder<ViewTaskBloc, ViewTaskState>(
                        builder: (context, state) {
                          if (state is ViewTaskLoading) {
                            // shimmer effect when task is loading
                            return Skeletonizer(
                              enabled: true,
                              enableSwitchAnimation: true,
                              child: CustomTaskListTile(
                                taskTitle: "No task",
                                taskDescription: "No Description",
                                onTap: () {},
                              ),
                            );
                          } else if (state is ViewTaskLoaded) {
                            final tasks = state.tasks;

                            if (tasks.isEmpty) {
                              // no task found  widget
                              return CustomNoTaskFound(
                                svgPath: Assets.img.svg.noTask,
                                text: appLocalization.noTaskFound,
                                imgHeight: 180.h,
                                imgWidth: 180.w,
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                final task = tasks[index];

                                // task widget
                                return CustomTaskListTile(
                                  taskTitle: task["taskName"],
                                  taskDescription: task["taskDescription"],
                                  onTap: () {
                                    // task description screen
                                    GoRouter.of(context).pushNamed(
                                      "taskDescription",
                                      extra: {
                                        "taskId": task["taskId"],
                                        "taskPriority": task["taskPriority"],
                                        "taskStatus": task["taskStatus"],
                                        "taskName": task["taskName"],
                                        "taskDescription":
                                            task["taskDescription"],
                                        "notificationAlert":
                                            task["notificationAlert"] ?? false,
                                        "dateRange": task["dateRange"] ?? [],
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          } else if (state is ViewTaskError) {
                            // error widget
                            return CustomNoTaskFound(
                              svgPath: Assets.img.svg.errorFound,
                              text: state.message,
                              imgHeight: 180.h,
                              imgWidth: 180.w,
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
