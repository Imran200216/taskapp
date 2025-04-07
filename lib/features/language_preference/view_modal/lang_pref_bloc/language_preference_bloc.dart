import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'language_preference_event.dart';

part 'language_preference_state.dart';

class LanguagePreferenceBloc
    extends Bloc<LanguagePreferenceEvent, LanguagePreferenceState> {
  LanguagePreferenceBloc() : super(LanguagePreferenceInitial()) {
    on<LoadLanguagePreference>((event, emit) async {
      final box = Hive.box('userLanguagePreferenceBox');
      final storedLanguage = box.get("selectedLanguage");

      if (storedLanguage != null && storedLanguage is String) {
        emit(
          LangPreferenceSelected(
            selectedLanguage: storedLanguage,
            isUserSelected: false,
          ),
        );
      } else {
        // Fallback to English
        await box.put("selectedLanguage", "English");
        emit(
          LangPreferenceSelected(
            selectedLanguage: "English",
            isUserSelected: false,
          ),
        );
      }
    });


    on<ToggleLanguage>((event, emit) async {
      final box = Hive.box('userLanguagePreferenceBox');
      await box.put("selectedLanguage", event.language);
      emit(
        LangPreferenceSelected(
          selectedLanguage: event.language,
          isUserSelected: event.isUserSelected,
        ),
      );
    });

    on<LanguagePreferenceValidationFailed>((event, emit) {
      emit(LanguagePreferenceFailure());
    });
  }
}
