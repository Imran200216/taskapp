import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomBuildQuoteDisplay extends StatelessWidget {
  final String quote;
  final String author;

  const CustomBuildQuoteDisplay({
    super.key,
    required this.quote,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Starting quotes
        SvgPicture.asset(
          Assets.icon.svg.quoteStarting,
          height: 50.h,
          width: 50.w,
          fit: BoxFit.cover,
          color: ColorName.profileBgColor,
        ),

        SizedBox(height: 20.h),

        /// Quote Text
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            '"$quote"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: ColorName.primary,
            ),
          ),
        ),

        SizedBox(height: 10.h),

        /// Author Name
        Text(
          author.isNotEmpty ? "- $author" : "",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: ColorName.grey,
          ),
        ),

        SizedBox(height: 20.h),

        /// Ending quotes
        SvgPicture.asset(
          Assets.icon.svg.quoteEnding,
          height: 50.h,
          width: 50.w,
          fit: BoxFit.cover,
          color: ColorName.profileBgColor,
        ),
      ],
    );
  }
}
