part of 'quote_bloc.dart';

sealed class QuoteEvent extends Equatable {
  const QuoteEvent();
}

class FetchQuote extends QuoteEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UpdateQuote extends QuoteEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}