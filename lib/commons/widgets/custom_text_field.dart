import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomTextField extends StatefulWidget {
  final bool readOnly;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final bool hasBorder;
  final TextEditingController? textEditingController;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? contentPadding; // Added parameter
  final double topRightRadius; // Added for custom radius
  final double bottomLeftRadius; // Added for custom radius
  final double topLeftRadius;
  final double bottomRightRadius;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.hasBorder = false,
    this.textEditingController,
    this.onTap,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.contentPadding, // Default to null to allow customization
    this.topRightRadius = 6.0, // Default top-right radius
    this.bottomLeftRadius = 6.0,
    this.topLeftRadius = 6.0,
    this.bottomRightRadius = 6.0, // Default bottom-left radius
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true; // State for toggling visibility

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      readOnly: widget.readOnly,
      onChanged: widget.onChanged,
      validator: widget.validator,
      cursorColor: ColorName.primary,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      controller: widget.textEditingController,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: ColorName.black,
        fontWeight: FontWeight.w500,
      ),
      obscureText: widget.isPassword ? _isObscure : false,
      decoration: InputDecoration(
        fillColor: ColorName.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              widget.hasBorder
                  ? BorderSide(color: ColorName.grey, width: 1.w)
                  : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              widget.hasBorder
                  ? BorderSide(color: ColorName.grey, width: 1.w)
                  : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              widget.hasBorder
                  ? BorderSide(color: ColorName.grey, width: 1.w)
                  : BorderSide.none,
        ),
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: ColorName.grey,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(widget.prefixIcon, color: ColorName.primary),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: ColorName.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
                : null,
        contentPadding:
            widget.contentPadding ??
            EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
        errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: ColorName.authErrorColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
