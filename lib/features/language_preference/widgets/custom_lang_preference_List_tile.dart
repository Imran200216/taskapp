import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomLangPreferenceListTile extends StatelessWidget {
  final String title;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const CustomLangPreferenceListTile({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: ColorName.grey, width: 0.6.w),
      ),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: ColorName.black,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
        value: isChecked,
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
          side: const BorderSide(color: ColorName.grey),
        ),
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}
