part of 'view_task_bloc.dart';

sealed class ViewTaskEvent extends Equatable {
  const ViewTaskEvent();
}

class FetchUserTasks extends ViewTaskEvent {
  const FetchUserTasks();

  @override
  List<Object> get props => [];
}
