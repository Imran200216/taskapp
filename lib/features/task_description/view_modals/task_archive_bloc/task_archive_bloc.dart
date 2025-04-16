import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:taskapp/core/core_exports.dart';

part 'task_archive_event.dart';

part 'task_archive_state.dart';

class TaskArchiveBloc extends Bloc<TaskArchiveEvent, TaskArchiveState> {
  final TaskService taskService;

  TaskArchiveBloc(this.taskService) : super(const TaskArchiveInitial()) {
    on<ArchiveTaskEvent>(_onArchiveTask);
    on<RemoveArchiveTaskEvent>(_onRemoveArchiveTask);
    on<SetArchiveStatusEvent>(_onSetArchiveStatus);
  }

  Future<void> _onArchiveTask(
    ArchiveTaskEvent event,
    Emitter<TaskArchiveState> emit,
  ) async {
    emit(TaskArchiveLoading(isArchived: state.isArchived));
    try {
      await taskService.updateTask(
        context: event.context,
        taskId: event.taskId,
        updatedData: {'isArchived': true},
      );
      emit(TaskArchiveSuccess('Task archived successfully', isArchived: true));
    } catch (e) {
      emit(TaskArchiveFailure(e.toString(), isArchived: state.isArchived));
    }
  }

  Future<void> _onRemoveArchiveTask(
    RemoveArchiveTaskEvent event,
    Emitter<TaskArchiveState> emit,
  ) async {
    emit(TaskArchiveLoading(isArchived: state.isArchived));
    try {
      await taskService.updateTask(
        context: event.context,
        taskId: event.taskId,
        updatedData: {'isArchived': false},
      );
      emit(
        TaskArchiveSuccess('Task unarchived successfully', isArchived: false),
      );
    } catch (e) {
      emit(TaskArchiveFailure(e.toString(), isArchived: state.isArchived));
    }
  }

  void _onSetArchiveStatus(
      SetArchiveStatusEvent event,
      Emitter<TaskArchiveState> emit,
      ) {
    emit(
      TaskArchiveSuccess(
        'Status updated manually',
        isArchived: event.isArchived,
        showToast: false, // 🔥 don't show toast on init
      ),
    );
  }

}
