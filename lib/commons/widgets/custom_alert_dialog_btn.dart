import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskapp/core/service/haptic_feedback_service.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomAlertDialogBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String btnTitle;
  final bool isLoading;
  final String iconPath;
  final Color btnBgColor;
  final Color btnTextColor;
  final Color btnIconColor;

  const CustomAlertDialogBtn({
    super.key,
    required this.onTap,
    required this.btnTitle,
    this.isLoading = false,
    required this.iconPath,
    required this.btnBgColor,
    required this.btnTextColor,
    required this.btnIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          isLoading
              ? null
              : () {
                HapticFeedbackUtilityService.mediumImpact();

                onTap();
              }, // Disable tap when loading
      child: Container(
        height: 30.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: isLoading ? btnBgColor.withOpacity(0.7) : btnBgColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isLoading)
              SvgPicture.asset(
                iconPath,
                height: 16.w,
                width: 16.w,
                color: btnIconColor,
              ),
            if (!isLoading) SizedBox(width: 10.w),
            // Add spacing between icon and text
            isLoading
                ? SizedBox(
                  height: 20.w,
                  width: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(ColorName.white),
                  ),
                )
                : Text(
                  btnTitle,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: btnTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
