import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:hive/hive.dart';

class QuoteService {
  // dio client
  final Dio _dio = Dio();

  // translator
  final GoogleTranslator _translator = GoogleTranslator();

  // fetch daily quotes
  Future<Map<String, String>?> fetchDailyQuote({
    required String languageCode,
  }) async {
    try {
      final response = await _dio.get('https://zenquotes.io/api/today');

      if (response.statusCode == 200 && response.data is List) {
        var quoteData = response.data[0];
        String originalQuote = quoteData['q'];
        String author = quoteData['a'];

        // ✅ Ensure Hive box is initialized properly
        if (!Hive.isBoxOpen("userLanguagePreferenceBox")) {
          await Hive.openBox("userLanguagePreferenceBox");
        }
        final box = Hive.box("userLanguagePreferenceBox");
        String storedLang = box.get("selectedLanguage") ?? "English";

        debugPrint("📢 Retrieved Language from Hive: $storedLang");

        // Language map
        Map<String, String> langMap = {
          "English": "en",
          "Arabic": "ar",
          "Tamil": "ta",
          "French": "fr",
          "Hindi": "hi",
        };

        // Translate only if needed
        if (storedLang != "English" && langMap.containsKey(storedLang)) {
          String targetLang = langMap[storedLang]!;

          var translatedQuote = await _translator.translate(
            originalQuote,
            from: "en",
            to: targetLang,
          );

          var translatedAuthor = await _translator.translate(
            author,
            from: "en",
            to: targetLang,
          );

          return {
            "quote": translatedQuote.text,
            "author": translatedAuthor.text,
          };
        }

        return {"quote": originalQuote, "author": author};
      }
    } catch (e) {
      debugPrint("❌ Error fetching quote: $e");
    }
    return null;
  }
}
