part of 'view_archive_task_bloc.dart';

sealed class ViewArchiveTaskState extends Equatable {
  const ViewArchiveTaskState();
}

final class ViewArchiveTaskInitial extends ViewArchiveTaskState {
  @override
  List<Object> get props => [];
}

class ViewArchiveLoadingState extends ViewArchiveTaskState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ViewArchiveLoadedState extends ViewArchiveTaskState {
  final List<AddTaskModel> archivedTasks;

  const ViewArchiveLoadedState(this.archivedTasks);

  @override
  // TODO: implement props
  List<Object?> get props => [archivedTasks];
}

class ViewArchiveErrorState extends ViewArchiveTaskState {
  final String errorMessage;

  const ViewArchiveErrorState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
