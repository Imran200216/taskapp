part of 'view_task_bloc.dart';

sealed class ViewTaskEvent extends Equatable {
  const ViewTaskEvent();
}

class FetchUserTasks extends ViewTaskEvent {
  final String userUid;

  const FetchUserTasks(this.userUid);

  @override
  List<Object> get props => [userUid];
}