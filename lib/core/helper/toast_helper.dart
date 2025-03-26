import 'package:flutter/material.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:toastification/toastification.dart';

class ToastHelper {
  static void showToast({
    required BuildContext context,
    required String message,
    required bool isSuccess,
  }) {
    toastification.show(
      context: context,
      title: Text(
        message,
        style: Theme.of(
          context,
        ).textTheme.bodySmall!.copyWith(color: ColorName.black),
      ),
      type: isSuccess ? ToastificationType.success : ToastificationType.error,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
