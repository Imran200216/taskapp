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
  final bool isUserSelected;

  const LangPreferenceSelected({
    required this.selectedLanguage,
    required this.isUserSelected,
  });

  @override
  List<Object?> get props => [selectedLanguage, isUserSelected];
}

class LanguagePreferenceFailure extends LanguagePreferenceState {
  final DateTime timestamp;

  LanguagePreferenceFailure() : timestamp = DateTime.now();

  @override
  List<Object?> get props => [timestamp];
}
