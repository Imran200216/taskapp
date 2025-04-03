import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskapp/core/service/haptic_feedback_service.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomTaskListTile extends StatelessWidget {
  final String taskTitle;
  final String taskDescription;
  final VoidCallback onTap;

  const CustomTaskListTile({
    super.key,
    required this.taskTitle,
    required this.taskDescription,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: ColorName.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
        side: BorderSide(color: ColorName.grey, width: 0.6.w),
      ),
      color: ColorName.white,
      child: ListTile(
        onTap: () {
          HapticFeedbackUtilityService.mediumImpact();

          onTap();
        },

        /// leading icon
        leading: SvgPicture.asset(
          Assets.icon.svg.taskLeading,
          height: 30.h,
          width: 30.w,
          fit: BoxFit.cover,
          color: ColorName.primary,
        ),
        // title
        title: Text(taskTitle),
        // sub title
        subtitle: Text(taskDescription),
        // trailing
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: ColorName.primary,
          size: 16.h,
        ),

        // styles
        titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: ColorName.primary,
          fontWeight: FontWeight.w600,
          fontSize: 13.2.sp,
        ),

        subtitleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: ColorName.grey,
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
