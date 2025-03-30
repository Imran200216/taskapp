part of 'add_task_bloc.dart';

sealed class AddTaskEvent extends Equatable {
  const AddTaskEvent();
}

class AddTask extends AddTaskEvent {
  final String taskId;
  final String userUid;
  final String taskName;
  final String taskDescription;
  final List<DateTime> dateRange; // ✅ Changed from String to List<DateTime>
  final bool notificationAlert;
  final String taskStatus;
  final String taskPriority;
  final BuildContext context;

  const AddTask({
    required this.taskId,
    required this.userUid,
    required this.taskName,
    required this.taskDescription,
    required this.dateRange, // ✅ Now a list of DateTime
    required this.notificationAlert,
    required this.taskStatus,
    required this.taskPriority,
    required this.context,
  });

  @override
  List<Object> get props => [
    taskId,
    userUid,
    taskName,
    taskDescription,
    dateRange, // ✅ Added to props
    notificationAlert,
    taskStatus,
    taskPriority,
  ];
}


/// Event for fetching tasks
class FetchTasks extends AddTaskEvent {
  final String userUid;

  const FetchTasks({required this.userUid});

  @override
  List<Object> get props => [userUid];
}

/// Event for updating a task
class UpdateTask extends AddTaskEvent {
  final String taskId;
  final Map<String, dynamic> updatedData;
  final BuildContext context;

  const UpdateTask({
    required this.taskId,
    required this.updatedData,
    required this.context,
  });

  @override
  List<Object> get props => [taskId, updatedData];
}

/// Event for deleting a task
class DeleteTask extends AddTaskEvent {
  final String taskId;
  final BuildContext context;

  const DeleteTask({required this.taskId, required this.context});

  @override
  List<Object> get props => [taskId];
}
