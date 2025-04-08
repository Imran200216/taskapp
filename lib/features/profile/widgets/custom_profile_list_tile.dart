import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/core/service/haptics/haptic_feedback_service.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomProfileListTile extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final bool isSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final bool showTrailing; // Added flag to make trailing optional

  const CustomProfileListTile({
    super.key,
    this.onTap,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.isSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.showTrailing = true, // Default is true
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap != null
          ? () {
        HapticFeedbackUtilityService.mediumImpact();
        onTap!();
      }
          : null,

      // Leading icon
      leading: Icon(leadingIcon, color: ColorName.primary, size: 20.h),

      // Trailing widget (only if showTrailing is true)
      trailing: showTrailing
          ? (isSwitch
          ? Switch.adaptive(
        value: switchValue,
        onChanged: onSwitchChanged,
        activeColor: ColorName.primary,
      )
          : Icon(
        Icons.arrow_forward_ios,
        color: ColorName.primary,
        size: 12.h,
      ))
          : null,

      // Title & Subtitle
      title: Text(title),
      subtitle: Text(subtitle),

      // Style of title and subtitle
      titleTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: ColorName.primary,
        fontWeight: FontWeight.w400,
        fontSize: 11.sp,
      ),
      subtitleTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: ColorName.primary,
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
      ),
    );
  }
}
