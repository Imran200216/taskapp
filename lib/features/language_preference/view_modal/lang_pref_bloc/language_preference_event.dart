part of 'language_preference_bloc.dart';

sealed class LanguagePreferenceEvent extends Equatable {
  const LanguagePreferenceEvent();
}

class LoadLanguagePreference extends LanguagePreferenceEvent {
  @override
  List<Object?> get props => [];
}

class ToggleLanguage extends LanguagePreferenceEvent {
  final String language;

  const ToggleLanguage({required this.language});

  @override
  List<Object> get props => [language];
}

class LanguagePreferenceValidationFailed extends LanguagePreferenceEvent {
  @override
  List<Object?> get props => [];
}
