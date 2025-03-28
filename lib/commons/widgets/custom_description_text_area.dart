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
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorName.grey, width: 1.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 4.h),
                child: Icon(prefixIcon, color: ColorName.primary, size: 18.h),
              ),
            ),
            Expanded(
              flex: 12,
              child: TextFormField(
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
                  hintText: hintText,
                  hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorName.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorName.authErrorColor,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  // Removes the underline
                  enabledBorder: InputBorder.none,
                  // Removes when not focused
                  focusedBorder: InputBorder.none, // Removes when focused
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
