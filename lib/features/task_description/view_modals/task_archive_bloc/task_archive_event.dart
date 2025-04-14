part of 'task_archive_bloc.dart';

sealed class TaskArchiveEvent extends Equatable {
  const TaskArchiveEvent();
}

/// Archive a task (set isArchived = true)
class ArchiveTaskEvent extends TaskArchiveEvent {
  final String taskId;
  final BuildContext context;

  const ArchiveTaskEvent(this.taskId, this.context);

  @override
  List<Object> get props => [taskId];
}

/// Unarchive a task (set isArchived = false)
class RemoveArchiveTaskEvent extends TaskArchiveEvent {
  final String taskId;
  final BuildContext context;

  const RemoveArchiveTaskEvent(this.taskId, this.context);

  @override
  List<Object> get props => [taskId];
}

/// Set archive status manually (used to initialize or update state directly)
class SetArchiveStatusEvent extends TaskArchiveEvent {
  final bool isArchived;

  const SetArchiveStatusEvent(this.isArchived);

  @override
  List<Object> get props => [isArchived];
}