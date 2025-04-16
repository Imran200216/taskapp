part of 'task_archive_bloc.dart';

sealed class TaskArchiveState extends Equatable {
  final bool isArchived;

  const TaskArchiveState({required this.isArchived});

  @override
  List<Object?> get props => [isArchived];
}

class TaskArchiveInitial extends TaskArchiveState {
  const TaskArchiveInitial() : super(isArchived: false);
}

class TaskArchiveLoading extends TaskArchiveState {
  const TaskArchiveLoading({required super.isArchived});
}

class TaskArchiveSuccess extends TaskArchiveState {
  final String message;
  final bool showToast;

  const TaskArchiveSuccess(
      this.message, {
        required super.isArchived,
        this.showToast = true, // default to true
      });

  @override
  List<Object?> get props => [message, isArchived, showToast];
}


class TaskArchiveFailure extends TaskArchiveState {
  final String error;

  const TaskArchiveFailure(this.error, {required super.isArchived});

  @override
  List<Object?> get props => [error, isArchived];
}
