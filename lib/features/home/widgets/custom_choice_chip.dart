import 'package:flutter/material.dart';
import 'package:taskapp/gen/colors.gen.dart';

class CustomChoiceChip extends StatelessWidget {
  final int index;
  final String label;
  final bool isSelected;
  final Function(int) onSelected;

  const CustomChoiceChip({
    super.key,
    required this.index,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? ColorName.white : ColorName.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) => onSelected(index),
      selectedColor: ColorName.primary,
      backgroundColor: Colors.grey.shade300,
      checkmarkColor: isSelected ? ColorName.white : null,
    );
  }
}
