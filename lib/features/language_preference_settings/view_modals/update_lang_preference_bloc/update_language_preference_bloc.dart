import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'update_language_preference_event.dart';

part 'update_language_preference_state.dart';

class UpdateLanguagePreferenceBloc
    extends Bloc<UpdateLanguagePreferenceEvent, UpdateLanguagePreferenceState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UpdateLanguagePreferenceBloc() : super(UpdateLanguagePreferenceInitial()) {
    // update user lang pref bloc
    on<UpdateUserLanguagePreferenceEvent>(_onUpdateLanguagePreference);
  }

  // update functionality
  Future<void> _onUpdateLanguagePreference(
    UpdateUserLanguagePreferenceEvent event,
    Emitter<UpdateLanguagePreferenceState> emit,
  ) async {
    emit(UpdateLanguagePreferenceLoading());

    try {
      await _firestore.collection('users').doc(event.uid).update({
        'userLanguagePreference': event.newLanguagePreference,
      });

      emit(UpdateLanguagePreferenceSuccess());
    } catch (e) {
      emit(UpdateLanguagePreferenceFailure(e.toString()));
    }
  }
}
