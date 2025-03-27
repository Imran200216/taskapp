import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomDateRangePickerTextField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? textEditingController;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool hasBorder;
  final EdgeInsetsGeometry? contentPadding;

  const CustomDateRangePickerTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.textEditingController,
    this.onTap,
    this.validator,
    this.onChanged,
    this.hasBorder = false,
    this.contentPadding,
  });

  @override
  State<CustomDateRangePickerTextField> createState() => _CustomDateRangePickerTextFieldState();
}

class _CustomDateRangePickerTextFieldState extends State<CustomDateRangePickerTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(now.year - 10);
    DateTime lastDate = DateTime(now.year + 10);

    DateTimeRange? pickedRange = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorName.primary,
              onPrimary: Colors.white,
              onSurface: ColorName.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedRange != null) {
      setState(() {
        _controller.text = "${pickedRange.start.toString().split(' ')[0]} - ${pickedRange.end.toString().split(' ')[0]}";
        widget.onChanged?.call(_controller.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController ?? _controller,
      readOnly: true,
      validator: widget.validator,
      cursorColor: ColorName.primary,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: ColorName.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        fillColor: ColorName.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: widget.hasBorder ? BorderSide(color: ColorName.grey, width: 1.w) : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: widget.hasBorder ? BorderSide(color: ColorName.grey, width: 1.w) : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: widget.hasBorder ? BorderSide(color: ColorName.grey, width: 1.w) : BorderSide.none,
        ),
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: ColorName.grey,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(widget.prefixIcon, color: ColorName.primary),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today, color: ColorName.primary),
          onPressed: () => _selectDateRange(context),
        ),
        contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
        errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: ColorName.authErrorColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () => _selectDateRange(context),
    );
  }
}
