part of 'language_preference_bloc.dart';

sealed class LanguagePreferenceEvent extends Equatable {
  const LanguagePreferenceEvent();
}

class ToggleLanguage extends LanguagePreferenceEvent {
  final String language;

  const ToggleLanguage({required this.language});

  @override
  List<Object> get props => [language];
}