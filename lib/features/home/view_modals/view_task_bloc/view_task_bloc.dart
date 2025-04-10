import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'view_task_event.dart';

part 'view_task_state.dart';

class ViewTaskBloc extends Bloc<ViewTaskEvent, ViewTaskState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ViewTaskBloc() : super(ViewTaskInitial()) {
    on<FetchUserTasks>(_onFetchUserTasks);
  }

  Future<void> _onFetchUserTasks(
    FetchUserTasks event,
    Emitter<ViewTaskState> emit,
  ) async {
    emit(ViewTaskLoading());
    try {
      // Open the Hive box for user preferences
      final box = await Hive.openBox("userLanguagePreferenceBox");

      // Retrieve the stored user UID
      String userId = box.get("userId");

      final querySnapshot =
          await _firestore
              .collection('tasks')
              .where('userUid', isEqualTo: userId)
              .get();

      final taskList =
          querySnapshot.docs.map((doc) {
            final data = doc.data();
            // Ensure 'taskId' exists and matches doc.id
            if (!data.containsKey('taskId') || data['taskId'] != doc.id) {
              data['taskId'] = doc.id; // assign it just in case
            }
            return data;
          }).toList();

      emit(ViewTaskLoaded(taskList));
    } catch (e) {
      emit(ViewTaskError('Failed to load tasks: ${e.toString()}'));
    }
  }
}
