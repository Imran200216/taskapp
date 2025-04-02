part of 'update_language_preference_bloc.dart';

sealed class UpdateLanguagePreferenceEvent extends Equatable {
  const UpdateLanguagePreferenceEvent();
}

class UpdateUserLanguagePreferenceEvent extends UpdateLanguagePreferenceEvent {
  final String uid;
  final String newLanguagePreference;

  const UpdateUserLanguagePreferenceEvent({
    required this.uid,
    required this.newLanguagePreference,
  });

  @override
  List<Object> get props => [uid, newLanguagePreference];
}