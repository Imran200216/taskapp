import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskapp/features/add_task/add_task_exports.dart';
import 'package:taskapp/core/core_exports.dart';

part 'view_archive_task_event.dart';

part 'view_archive_task_state.dart';

class ViewArchiveTaskBloc
    extends Bloc<ViewArchiveTaskEvent, ViewArchiveTaskState> {
  final TaskService _taskService;

  // Constructor
  ViewArchiveTaskBloc(this._taskService) : super(ViewArchiveTaskInitial());

  Stream<ViewArchiveTaskState> mapEventToState(
    ViewArchiveTaskEvent event,
  ) async* {
    if (event is FetchArchivedTasksEvent) {
      yield ViewArchiveLoadingState();

      try {
        final archivedTasksStream = _taskService.getArchivedTasks();

        // Await the stream for changes and yield the updated data
        await for (var tasks in archivedTasksStream) {
          yield ViewArchiveLoadedState(tasks);
        }
      } catch (e) {
        yield ViewArchiveErrorState(e.toString());
      }
    }
  }
}
