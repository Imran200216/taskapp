part of 'view_task_bloc.dart';

sealed class ViewTaskState extends Equatable {
  const ViewTaskState();

  @override
  List<Object> get props => [];
}

class ViewTaskInitial extends ViewTaskState {}

class ViewTaskLoading extends ViewTaskState {}

class ViewTaskLoaded extends ViewTaskState {
  final List<Map<String, dynamic>> tasks;

  const ViewTaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class ViewTaskError extends ViewTaskState {
  final String message;

  const ViewTaskError(this.message);

  @override
  List<Object> get props => [message];
}
