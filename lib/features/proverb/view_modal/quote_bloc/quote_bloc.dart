import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskapp/core/service/quote_service.dart';

part 'quote_event.dart';

part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteService quoteService;

  QuoteBloc(this.quoteService) : super(QuoteInitial()) {
    on<FetchQuote>((event, emit) async {
      emit(QuoteLoading());

      try {
        final data = await quoteService.fetchDailyQuote();
        if (data != null) {
          emit(QuoteLoaded(data["quote"]!, data["author"]!));
        } else {
          emit(QuoteError("Failed to load quote."));
        }
      } catch (e) {
        emit(QuoteError("Error fetching quote."));
      }
    });
  }
}
