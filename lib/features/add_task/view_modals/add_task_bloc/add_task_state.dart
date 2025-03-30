part of 'add_task_bloc.dart';

sealed class AddTaskState extends Equatable {
  const AddTaskState();
}

final class AddTaskInitial extends AddTaskState {
  @override
  List<Object> get props => [];
}

/// Loading state
class AddTaskLoading extends AddTaskState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

/// Task successfully added
class AddTaskSuccess extends AddTaskState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

/// Task successfully fetched
class TasksLoaded extends AddTaskState {
  final List<AddTaskModel> tasks;

  const TasksLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

/// Task updated
class TaskUpdated extends AddTaskState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

/// Task deleted
class TaskDeleted extends AddTaskState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

/// Error state
class AddTaskFailure extends AddTaskState {
  final String error;

  const AddTaskFailure({required this.error});

  @override
  List<Object> get props => [error];
}