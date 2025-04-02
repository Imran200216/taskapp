part of 'update_language_preference_bloc.dart';

sealed class UpdateLanguagePreferenceState extends Equatable {
  const UpdateLanguagePreferenceState();
}

final class UpdateLanguagePreferenceInitial extends UpdateLanguagePreferenceState {
  @override
  List<Object> get props => [];
}

class UpdateLanguagePreferenceLoading extends UpdateLanguagePreferenceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateLanguagePreferenceSuccess extends UpdateLanguagePreferenceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateLanguagePreferenceFailure extends UpdateLanguagePreferenceState {
  final String error;

  const UpdateLanguagePreferenceFailure(this.error);

  @override
  List<Object> get props => [error];
}