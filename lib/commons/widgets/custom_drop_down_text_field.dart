import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomDropdownTextField<T> extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?>? onChanged;
  final T? selectedValue;
  final bool hasBorder;
  final FormFieldValidator<T>? validator;
  final EdgeInsetsGeometry? contentPadding;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double topLeftRadius;
  final double bottomRightRadius;

  const CustomDropdownTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.items,
    required this.itemLabel,
    this.onChanged,
    this.selectedValue,
    this.hasBorder = false,
    this.validator,
    this.contentPadding,
    this.topRightRadius = 6.0,
    this.bottomLeftRadius = 6.0,
    this.topLeftRadius = 6.0,
    this.bottomRightRadius = 6.0,
  });

  @override
  State<CustomDropdownTextField<T>> createState() =>
      _CustomDropdownTextFieldState<T>();
}

class _CustomDropdownTextFieldState<T> extends State<CustomDropdownTextField<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: _selectedValue,
      validator: widget.validator,
      decoration: InputDecoration(
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
        prefixIcon: Icon(widget.prefixIcon, color: ColorName.primary),
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
        errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: ColorName.authErrorColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      items: widget.items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            widget.itemLabel(value),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: ColorName.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
      onChanged: (T? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
        widget.onChanged?.call(newValue);
      },
    );
  }
}
