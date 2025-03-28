import 'package:flutter/material.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class AppValidator {
  // validation of email
  static String? validateEmail(BuildContext context, String? value) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return appLocalization.emailRequired;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return appLocalization.invalidEmail;
    }
    return null;
  }

  //  validation of password
  static String? validatePassword(BuildContext context, String? value) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return appLocalization.passwordRequired;
    } else if (value.length < 6) {
      return appLocalization.passwordMinLength;
    }
    return null;
  }

  //  validation of confirm password
  static String? validateConfirmPassword(
    BuildContext context,
    String? password,
    String? confirmPassword,
  ) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    if (confirmPassword == null || confirmPassword.isEmpty) {
      return appLocalization.confirmPasswordRequired;
    } else if (password != confirmPassword) {
      return appLocalization.passwordsDoNotMatch;
    }
    return null;
  }

  // validation of name
  static String? validateName(BuildContext context, String? value) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return appLocalization.nameRequired;
    } else if (value.length < 3) {
      return appLocalization.nameMinLength;
    }
    return null;
  }

  // Validation for Task Name
  static String? validateTaskName(BuildContext context, String? value) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return appLocalization.taskNameRequired;
    } else if (value.length < 3) {
      return appLocalization.taskNameMinLength;
    }
    return null;
  }

  // Validation for Task Description
  static String? validateTaskDescription(BuildContext context, String? value) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return appLocalization.taskDescriptionRequired;
    } else if (value.length < 10) {
      return appLocalization.taskDescriptionMinLength;
    }
    return null;
  }

  // Validation for Notification Alert
  static String? validateNotificationAlert(
    BuildContext context,
    String? value,
  ) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return appLocalization.notificationRequired;
    }
    return null;
  }

  // Validation for Date Range Picking
  static String? validateDateRange(BuildContext context, String? value) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return appLocalization.dateRangeRequired;
    }
    return null;
  }

  // Validation for Task Status
  static String? validateTaskStatus(BuildContext context, String? value) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return appLocalization.taskStatusRequired;
    }
    return null;
  }

  // Validation for Task Priority
  static String? validateTaskPriority(BuildContext context, String? value) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return appLocalization.taskPriorityRequired;
    }
    return null;
  }
}
