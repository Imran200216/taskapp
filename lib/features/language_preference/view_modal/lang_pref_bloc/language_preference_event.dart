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
  final bool isUserSelected;

  const ToggleLanguage({required this.language, required this.isUserSelected});

  @override
  List<Object> get props => [language, isUserSelected];
}

class LanguagePreferenceValidationFailed extends LanguagePreferenceEvent {
  @override
  List<Object?> get props => [];
}
