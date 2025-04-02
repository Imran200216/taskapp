import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskapp/core/service/quote_service.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteService quoteService;

  QuoteBloc(this.quoteService) : super(QuoteInitial()) {
    on<FetchQuote>(_onFetchQuote);
  }

  Future<void> _onFetchQuote(FetchQuote event, Emitter<QuoteState> emit) async {
    emit(QuoteLoading());

    try {
      // ✅ Always get the latest stored language preference
      final box = await Hive.openBox("userLanguagePreferenceBox");
      String storedLang = box.get("selectedLanguage") ?? "English";
      debugPrint("📢 Current Language in Bloc: $storedLang");

      final data = await quoteService.fetchDailyQuote();
      if (data != null && data.containsKey("quote") && data.containsKey("author")) {
        emit(QuoteLoaded(data["quote"]!, data["author"]!));
      } else {
        emit(QuoteError("Failed to load quote."));
      }
    } catch (e) {
      debugPrint("❌ Error in QuoteBloc: $e"); // ✅ Debugging log
      emit(QuoteError("Error fetching quote."));
    }
  }
}
