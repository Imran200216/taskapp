import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              // navigate to back
              GoRouter.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: ColorName.primary),
          ),
          // title
          title: Text(taskName),
          // title style
          titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: ColorName.primary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: Column(
          children: [
            Text(taskId, style: TextStyle()),
            Text(taskDescription),
            Text(taskPriority),
          ],
        ),
      ),
    );
  }
}
