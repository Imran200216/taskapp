part of 'view_archive_task_bloc.dart';

sealed class ViewArchiveTaskEvent extends Equatable {
  const ViewArchiveTaskEvent();
}

class FetchArchivedTasksEvent extends ViewArchiveTaskEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
