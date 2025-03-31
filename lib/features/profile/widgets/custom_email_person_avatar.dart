import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomEmailPersonAvatar extends StatelessWidget {
  final String userEmailFirstLetter;

  const CustomEmailPersonAvatar({
    super.key,
    required this.userEmailFirstLetter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74.h,
      height: 74.w,
      decoration: BoxDecoration(
        color: ColorName.profileEmailBgColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Center(
        child: Text(
          userEmailFirstLetter,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: ColorName.primary,
            fontSize: 34.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
