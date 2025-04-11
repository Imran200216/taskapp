import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomNoTaskFound extends StatelessWidget {
  final String svgPath;
  final String text;
  final double? imgHeight;
  final double? imgWidth;

  const CustomNoTaskFound({
    super.key,
    required this.svgPath,
    required this.text,
    this.imgHeight,
    this.imgWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgPath,
            height: imgHeight ?? 240.h,
            width: imgWidth ?? 240.w,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 12.h),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: ColorName.grey,
              fontWeight: FontWeight.w500,
              fontSize: 12.4.sp,
            ),
          ),
        ],
      ),
    );
  }
}
