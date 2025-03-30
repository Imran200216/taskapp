import 'package:dio/dio.dart';
import 'package:translator/translator.dart';
import 'package:hive/hive.dart';

class QuoteService {
  final Dio _dio = Dio();
  final GoogleTranslator _translator = GoogleTranslator();

  Future<Map<String, String>?> fetchDailyQuote() async {
    try {
      final response = await _dio.get('https://zenquotes.io/api/today');

      if (response.statusCode == 200 && response.data is List) {
        var quoteData = response.data[0];
        String originalQuote = quoteData['q'];
        String author = quoteData['a'];

        // Retrieve user language preference from Hive
        final box = await Hive.openBox("userLanguagePreferenceBox");
        String storedLang = box.get("selectedLanguage") ?? "English";

        // Language map
        Map<String, String> langMap = {
          "English": "en",
          "Arabic": "ar",
          "Tamil": "ta",
          "French": "fr",
          "Hindi": "hi",
        };

        // Check if translation is needed
        if (storedLang != "English" && langMap.containsKey(storedLang)) {
          String targetLang = langMap[storedLang]!;

          // Translate the quote
          var translatedQuote = await _translator.translate(
            originalQuote,
            from: "en",
            to: targetLang,
          );

          // Translate the author's name (fallback to original if it fails)
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
      print("Error fetching quote: $e");
    }
    return null;
  }
}
