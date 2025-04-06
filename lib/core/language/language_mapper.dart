import 'package:flutter/material.dart';

/// A list of supported locales in the application.
const supportedLocales = [
  Locale("ta"),
  Locale("en"),
  Locale("ar"),
  Locale("fr"),
  Locale("hi"),
];

/// Maps a stored language string to its corresponding [Locale].
Locale mapLanguage(String storedLang) {
  switch (storedLang.toLowerCase()) {
    case "english":
    case "en":
      return const Locale("en");
    case "tamil":
    case "ta":
      return const Locale("ta");
    case "arabic":
    case "ar":
      return const Locale("ar");
    case "french":
    case "fr":
      return const Locale("fr");
    case "hindi":
    case "hi":
      return const Locale("hi");
    default:
      return const Locale("en");
  }
}
