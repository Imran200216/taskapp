import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/commons/widgets/custom_text_field.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomTaskDescriptionLabelTextField extends StatelessWidget {
  final String textFieldText;
  final String textFieldLabel;
  final String textFieldHintText;
  final IconData textFieldPrefixIcon;

  const CustomTaskDescriptionLabelTextField({
    super.key,
    required this.textFieldText,
    required this.textFieldLabel,
    required this.textFieldHintText,
    required this.textFieldPrefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // label
        Text(
          textFieldLabel,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: ColorName.primary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),

        // task text field
        CustomTextField(
          readOnly: true,
          textEditingController: TextEditingController(text: textFieldText),
          hintText: textFieldHintText,
          prefixIcon: textFieldPrefixIcon,
          hasBorder: true,
        ),
      ],
    );
  }
}
