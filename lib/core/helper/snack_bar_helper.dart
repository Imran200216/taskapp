import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/gen/colors.gen.dart';

class SnackBarHelper {
  static void showSnackBar({
    required BuildContext context,
    required IconData leadingIcon,
    required String message,
    Color backgroundColor = ColorName.authErrorColor,
    Color textColor = ColorName.white,
    int durationInSeconds = 3,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(leadingIcon, color: ColorName.white, size: 20.sp),
            SizedBox(width: 8.w), // Spacing between icon and text
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
            GestureDetector(
              onTap: () => scaffoldMessenger.hideCurrentSnackBar(),
              child: Icon(Icons.close, color: ColorName.white),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }
}
