import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/core/service/add_task/add_task_service.dart';
import 'package:taskapp/features/add_task/modals/add_task_modal.dart';

part 'add_task_event.dart';

part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final AddTaskService _taskService;

  AddTaskBloc(this._taskService) : super(AddTaskInitial()) {
    /// Handle Add Task Event
    on<AddTask>((event, emit) async {
      emit(AddTaskLoading());
      try {
        await _taskService.addTask(
          context: event.context,
          taskId: event.taskId,
          userUid: event.userUid,
          taskName: event.taskName,
          taskDescription: event.taskDescription,
          dateRange: event.dateRange,
          notificationAlert: event.notificationAlert,
          taskStatus: event.taskStatus,
          taskPriority: event.taskPriority,
        );
        emit(AddTaskSuccess());
      } catch (e) {
        emit(AddTaskFailure(error: e.toString()));
      }
    });

    /// Handle Fetch Tasks Event
    on<FetchTasks>((event, emit) async {
      emit(AddTaskLoading());
      try {
        _taskService.getUserTasks(event.userUid).listen((tasks) {
          emit(TasksLoaded(tasks: tasks));
        });
      } catch (e) {
        emit(AddTaskFailure(error: e.toString()));
      }
    });

    /// Handle Update Task Event
    on<UpdateTask>((event, emit) async {
      emit(AddTaskLoading());
      try {
        await _taskService.updateTask(
          context: event.context,
          taskId: event.taskId,
          updatedData: event.updatedData,
        );
        emit(TaskUpdated());
      } catch (e) {
        emit(AddTaskFailure(error: e.toString()));
      }
    });

    /// Handle Delete Task Event
    on<DeleteTask>((event, emit) async {
      emit(AddTaskLoading());
      try {
        await _taskService.deleteTask(
          context: event.context,
          taskId: event.taskId,
        );
        emit(TaskDeleted());
      } catch (e) {
        emit(AddTaskFailure(error: e.toString()));
      }
    });
  }
}
