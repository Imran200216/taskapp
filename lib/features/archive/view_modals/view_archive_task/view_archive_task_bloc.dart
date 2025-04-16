import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskapp/features/add_task/add_task_exports.dart';
import 'package:taskapp/core/core_exports.dart';

part 'view_archive_task_event.dart';

part 'view_archive_task_state.dart';

class ViewArchiveTaskBloc
    extends Bloc<ViewArchiveTaskEvent, ViewArchiveTaskState> {
  final TaskService _taskService;

  ViewArchiveTaskBloc(this._taskService) : super(ViewArchiveTaskInitial()) {
    on<FetchArchivedTasksEvent>(_onFetchArchivedTasksEvent);
  }

  Future<void> _onFetchArchivedTasksEvent(
      FetchArchivedTasksEvent event,
      Emitter<ViewArchiveTaskState> emit,
      ) async {
    emit(ViewArchiveLoadingState());
    try {
      final archivedTasksStream = _taskService.getArchivedTasks();

      await for (var tasks in archivedTasksStream) {
        emit(ViewArchiveLoadedState(tasks));
      }
    } catch (e) {
      emit(ViewArchiveErrorState(e.toString()));
    }
  }
}

