import 'package:dio/dio.dart';

class QuoteService {
  final Dio _dio = Dio();

  Future<Map<String, String>?> fetchDailyQuote() async {
    try {
      final response = await _dio.get('https://zenquotes.io/api/today');

      if (response.statusCode == 200 && response.data is List) {
        var quoteData = response.data[0];
        return {"quote": quoteData['q'], "author": quoteData['a']};
      }
    } catch (e) {
      print("Error fetching quote: $e");
    }
    return null;
  }
}
