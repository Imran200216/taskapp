import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomDropDownTextField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool hasBorder;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator; // Added validator parameter

  const CustomDropDownTextField({
    super.key,
    required this.hasBorder,
    required this.hintText,
    required this.prefixIcon,
    required this.items,
    this.selectedValue,
    this.onChanged,
    this.contentPadding,
    this.validator, // Accepting validator
  });

  @override
  _CustomDropDownTextFieldState createState() =>
      _CustomDropDownTextFieldState();
}

class _CustomDropDownTextFieldState extends State<CustomDropDownTextField> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: widget.validator, // Using the validator parameter
      value: _selectedValue,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: ColorName.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        isDense: true,
        fillColor: ColorName.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: widget.hasBorder
              ? BorderSide(color: ColorName.grey, width: 1.w)
              : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: widget.hasBorder
              ? BorderSide(color: ColorName.grey, width: 1.w)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: widget.hasBorder
              ? BorderSide(color: ColorName.grey, width: 1.w)
              : BorderSide.none,
        ),
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: ColorName.grey,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: ColorName.primary,
          size: 18.h,
        ),
        contentPadding:
        widget.contentPadding ??
            EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
        errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: ColorName.authErrorColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      items: widget.items.map((String value) {
        return DropdownMenuItem<String>(

          value: value,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
        widget.onChanged?.call(newValue);
      },
      menuMaxHeight: 300.h,
    );
  }
}
