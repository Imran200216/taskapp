import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomNoTaskFound extends StatelessWidget {
  final String svgPath;
  final String text;

  const CustomNoTaskFound(
      {super.key, required this.svgPath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // svg image
          SvgPicture.asset(
            svgPath,
            height: 240.h,
            width: 240.w,
            fit: BoxFit.cover,
          ),

          //   no task found
          Text(
            textAlign: TextAlign.start,
            text,
            style: Theme
                .of(context)
                .textTheme
                .bodySmall!
                .copyWith(
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
