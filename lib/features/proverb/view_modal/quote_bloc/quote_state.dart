part of 'quote_bloc.dart';

sealed class QuoteState extends Equatable {
  const QuoteState();
}

final class QuoteInitial extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteLoading extends QuoteState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class QuoteLoaded extends QuoteState {
  final String quote;
  final String author;

  const QuoteLoaded(this.quote, this.author);

  @override
  List<Object?> get props => [quote, author];
}

class QuoteError extends QuoteState {
  final String message;

  const QuoteError(this.message);

  @override
  List<Object?> get props => [message];
}
