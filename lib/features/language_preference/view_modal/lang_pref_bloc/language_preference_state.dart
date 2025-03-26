part of 'language_preference_bloc.dart';

sealed class LanguagePreferenceState extends Equatable {
  const LanguagePreferenceState();
}

final class LanguagePreferenceInitial extends LanguagePreferenceState {
  @override
  List<Object> get props => [];
}

final class LangPreferenceSelected extends LanguagePreferenceState {
  final String selectedLanguage;

  const LangPreferenceSelected({required this.selectedLanguage});

  @override
  List<Object?> get props => [selectedLanguage];
}
