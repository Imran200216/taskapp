import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskapp/commons/widgets/custom_alert_dialog_btn.dart';
import 'package:taskapp/core/service/haptics/haptic_feedback_service.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomAlertDialog extends StatelessWidget {
  final String alertTitle;
  final String alertSubTitle;
  final String alertIcon;
  final VoidCallback onCancelTap;
  final VoidCallback onConfirmTap;
  final String cancelText;
  final String confirmText;

  const CustomAlertDialog({
    super.key,
    required this.alertTitle,
    required this.alertSubTitle,
    required this.alertIcon,
    required this.onCancelTap,
    required this.onConfirmTap,
    required this.cancelText,
    required this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      backgroundColor: ColorName.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Language SVG
          SvgPicture.asset(
            alertIcon,
            height: 22.h,
            width: 22.w,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 10.h),

          // Title of Language Preference Settings
          Text(
            alertTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: ColorName.primary,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 8.h),

          // Subtitle of Language Preference Settings
          Text(
            alertSubTitle,
            //
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: ColorName.grey,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 22.h),

          // Action Buttons
          Row(
            spacing: 20.w,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Cancel Button
              Expanded(
                child: CustomAlertDialogBtn(
                  onTap: () {
                    HapticFeedbackUtilityService.mediumImpact();

                    // close the dialog
                    onCancelTap();
                  },
                  btnTitle: cancelText,
                  iconPath: Assets.icon.svg.cancel,
                  btnBgColor: ColorName.cancelAlertDialogBgColor,
                  btnIconColor: ColorName.grey,
                  btnTextColor: ColorName.grey,
                ),
              ),

              // Confirm Button
              Expanded(
                child: CustomAlertDialogBtn(
                  onTap: () {
                    HapticFeedbackUtilityService.mediumImpact();

                    // on confirm tap
                    onConfirmTap();
                  },
                  btnTitle: confirmText,
                  iconPath: Assets.icon.svg.confirm,
                  btnBgColor: ColorName.primary,
                  btnIconColor: ColorName.white,
                  btnTextColor: ColorName.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
