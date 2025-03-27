import 'package:flutter/material.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class AppValidator {
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
}
