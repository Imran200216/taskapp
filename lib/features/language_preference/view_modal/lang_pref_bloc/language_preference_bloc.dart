import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_preference_event.dart';

part 'language_preference_state.dart';

class LanguagePreferenceBloc
    extends Bloc<LanguagePreferenceEvent, LanguagePreferenceState> {
  LanguagePreferenceBloc() : super(LanguagePreferenceInitial()) {
    // toggle language event
    on<ToggleLanguage>((event, emit) {
      // Emit the selected language, allowing only one selection at a time
      emit(LangPreferenceSelected(selectedLanguage: event.language));
    });
  }
}
