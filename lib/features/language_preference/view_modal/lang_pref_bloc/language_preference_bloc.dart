import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'language_preference_event.dart';

part 'language_preference_state.dart';

class LanguagePreferenceBloc
    extends Bloc<LanguagePreferenceEvent, LanguagePreferenceState> {
  LanguagePreferenceBloc() : super(LanguagePreferenceInitial()) {
    // toggle language event
    on<ToggleLanguage>((event, emit) async {
      final box = Hive.box('userLanguagePreferenceBox');
      await box.put("selectedLanguage", event.language);
      emit(LangPreferenceSelected(selectedLanguage: event.language));
    });
  }
}
