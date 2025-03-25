import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskapp/core/service/haptic_feedback_service.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomAuthSocialBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String btnTitle;
  final bool isLoading;
  final String iconPath;

  const CustomAuthSocialBtn({
    super.key,
    required this.onTap,
    required this.btnTitle,
    this.isLoading = false,
    required this.iconPath,
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
        height: 35.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: isLoading ? ColorName.white.withOpacity(0.7) : ColorName.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isLoading)
              SvgPicture.asset(iconPath, height: 18.w, width: 18.w),
            if (!isLoading) SizedBox(width: 10.w),
            // Add spacing between icon and text
            isLoading
                ? SizedBox(
                  height: 20.w,
                  width: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ColorName.primary,
                    ),
                  ),
                )
                : Text(
                  btnTitle,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorName.black.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
