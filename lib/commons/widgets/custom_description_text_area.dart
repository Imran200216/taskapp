import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomDescriptionTextArea extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? textEditingController;
  final bool readOnly;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final bool hasBorder;
  final int maxLines;

  const CustomDescriptionTextArea({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.textEditingController,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.onChanged,
    this.contentPadding,
    this.hasBorder = false,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: textEditingController,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      cursorColor: ColorName.primary,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: ColorName.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        fillColor: ColorName.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              hasBorder
                  ? BorderSide(color: ColorName.grey, width: 1.w)
                  : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              hasBorder
                  ? BorderSide(color: ColorName.grey, width: 1.w)
                  : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              hasBorder
                  ? BorderSide(color: ColorName.grey, width: 1.w)
                  : BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: ColorName.grey,
          fontWeight: FontWeight.w500,
        ),

        // ✅ FIXED Prefix Icon Alignment
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            top: 10.h,
            left: 10.w,
            right: 5.w,
            bottom: 62.h,
          ),
          child: SizedBox(
            width: 24.w, // Fixed width
            child: Align(
              alignment: Alignment.topLeft, // Align to top-left
              child: Icon(prefixIcon, color: ColorName.primary, size: 20.sp),
            ),
          ),
        ),

        // ✅ FIXED Prefix Icon Constraints to Allow Proper Spacing
        prefixIconConstraints: BoxConstraints(
          minWidth: 40.w, // Ensure space from text
          minHeight: 40.h, // Keep space between text & icon
        ),

        // ✅ Adjusted Content Padding to Move Text Down
        contentPadding:
            contentPadding ??
            EdgeInsets.only(top: 18.h, left: 12.w, right: 12.w, bottom: 0.h),

        errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: ColorName.authErrorColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
