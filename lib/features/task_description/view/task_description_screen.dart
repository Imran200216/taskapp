import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/core/core_exports.dart';
import 'package:taskapp/features/task_description/task_description_exports.dart';
import 'package:taskapp/gen/colors.gen.dart';

class TaskDescriptionScreen extends StatelessWidget {
  final String taskId;
  final String taskPriority;
  final String taskStatus;
  final String taskName;
  final String taskDescription;
  final bool notificationAlertStatus;
  final List<String> dateRange;

  const TaskDescriptionScreen({
    super.key,
    required this.taskId,
    required this.taskPriority,
    required this.taskStatus,
    required this.taskName,
    required this.taskDescription,
    required this.notificationAlertStatus,
    required this.dateRange,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // task archive bloc
        BlocProvider(create: (context) => locator.get<TaskArchiveBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<TaskArchiveBloc, TaskArchiveState>(
            listener: (context, state) {
              if (state is TaskArchiveSuccess) {
                // success toast
                ToastHelper.showToast(
                  context: context,
                  message: "Task added to archive",
                  isSuccess: true,
                );
              } else if (state is TaskArchiveFailure) {
                // failure toast
                ToastHelper.showToast(
                  context: context,
                  message: "Failed to update task archive status",
                  isSuccess: false,
                );
              }
            },
          ),
        ],
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorName.primary,
              actions: [
                BlocBuilder<TaskArchiveBloc, TaskArchiveState>(
                  builder: (context, state) {
                    final isArchived = state.isArchived;

                    return IconButton(
                      onPressed: () {
                        final bloc = context.read<TaskArchiveBloc>();
                        if (isArchived) {
                          bloc.add(RemoveArchiveTaskEvent(taskId, context));
                        } else {
                          bloc.add(ArchiveTaskEvent(taskId, context));
                        }
                      },
                      icon: Icon(
                        isArchived ? Icons.favorite : Icons.favorite_border,
                        color: ColorName.white,
                      ),
                    );
                  },
                ),
              ],
              leading: IconButton(
                onPressed: () {
                  // navigate to back
                  GoRouter.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios, color: ColorName.white),
              ),
              // title
              title: Text("Task Description"),
              // title style
              titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorName.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                spacing: 10.h,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // task name
                  CustomTaskDescriptionLabelTextField(
                    textFieldText: taskName,
                    textFieldLabel: "Task Name",
                    textFieldHintText: "Task name",
                    textFieldPrefixIcon: Icons.task_alt,
                  ),

                  // task description
                  CustomTaskDescriptionLabelTextField(
                    textFieldText: taskDescription,
                    textFieldLabel: "Task Description",
                    textFieldHintText: "Task Description",
                    textFieldPrefixIcon: Icons.description_outlined,
                  ),

                  // task date range
                  CustomTaskDescriptionLabelTextField(
                    textFieldText: "${dateRange.first} - ${dateRange.last}",
                    textFieldLabel: "Date Range",
                    textFieldHintText: "Start - End",
                    textFieldPrefixIcon: Icons.date_range,
                  ),

                  // task status
                  CustomTaskDescriptionLabelTextField(
                    textFieldText: taskStatus,
                    textFieldLabel: "Task Status",
                    textFieldHintText: "Task Status",
                    textFieldPrefixIcon: Icons.task_alt,
                  ),

                  // task priority
                  CustomTaskDescriptionLabelTextField(
                    textFieldText: taskPriority,
                    textFieldLabel: "Task Priority",
                    textFieldHintText: "Task Priority",
                    textFieldPrefixIcon: Icons.timeline_outlined,
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
