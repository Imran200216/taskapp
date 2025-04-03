import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/gen/colors.gen.dart';

class TaskDescriptionScreen extends StatelessWidget {
  const TaskDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AppBar(
          leading: IconButton(
            onPressed: () {
              // navigate to back
              GoRouter.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: ColorName.primary),
          ),
          // title
          title: Text("Task Name"),
          // title style
          titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: ColorName.primary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
