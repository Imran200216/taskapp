import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/core/core_exports.dart';
import 'package:taskapp/features/home/home_exports.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';
import 'package:taskapp/features/archive/archive_exports.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return MultiBlocProvider(
      providers: [
        // view archive task bloc
        BlocProvider(
          create:
              (context) =>
                  locator.get<ViewArchiveTaskBloc>()
                    ..add(FetchArchivedTasksEvent()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
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
                // internet connection snack bar
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
        child: SafeArea(
          child: Scaffold(
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// title about on boarding
                  Text(
                    textAlign: TextAlign.start,
                    appLocalization.archiveTask,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorName.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  /// Fetch and display archived tasks
                  BlocBuilder<ViewArchiveTaskBloc, ViewArchiveTaskState>(
                    builder: (context, state) {
                      if (state is ViewArchiveLoadingState) {
                        // Loading state
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ViewArchiveLoadedState) {
                        // Successfully fetched tasks
                        final tasks = state.archivedTasks; // Change here

                        if (tasks.isEmpty) {
                          return CustomNoTaskFound(
                            svgPath: Assets.img.svg.noArchive,
                            text: appLocalization.noArchiveFound,
                          );
                        }

                        // Display tasks in a ListView
                        return Expanded(
                          child: ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              final task = tasks[index];

                              // task widget
                              return CustomTaskListTile(
                                taskTitle: task.taskName,
                                taskDescription: task.taskDescription,
                                onTap: () {
                                  // task description screen
                                  GoRouter.of(context).pushNamed(
                                    "taskDescription",
                                    extra: {
                                      "taskId": task.taskId,
                                      "taskPriority": task.taskPriority,
                                      "taskStatus": task.taskStatus,
                                      "taskName": task.taskName,
                                      "taskDescription": task.taskDescription,
                                      "notificationAlert":
                                          task.notificationAlert,
                                      "dateRange": task.dateRange,
                                      "isArchived": task.isArchived,
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        );
                      } else if (state is ViewArchiveErrorState) {
                        // Error state
                        return Center(child: Text(state.errorMessage));
                      }

                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
