import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/features/add_task/modals/add_task_modal.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class AddTaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// **Add Task to Firestore**
  Future<void> addTask({
    required BuildContext context,
    required String taskId,
    required String userUid,
    required String taskName,
    required String taskDescription,
    required List<DateTime> dateRange, // ✅ Changed from String to List<DateTime>
    required bool notificationAlert,
    required String taskStatus,
    required String taskPriority,
  }) async {
    try {
      AddTaskModel task = AddTaskModel(
        taskId: taskId,
        userUid: userUid,
        taskName: taskName,
        taskDescription: taskDescription,
        dateRange: dateRange.map((date) => date.toIso8601String()).toList(), // ✅ Convert to List<String>
        notificationAlert: notificationAlert,
        taskStatus: taskStatus,
        taskPriority: taskPriority,
      );

      await _firestore.collection('tasks').doc(taskId).set(task.toJson());
    } on FirebaseException catch (e) {
      throw _handleFirestoreError(context, e);
    }
  }

  /// **Retrieve Tasks for a User**
  Stream<List<AddTaskModel>> getUserTasks(String userUid) {
    return _firestore
        .collection('tasks')
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        List<DateTime> parsedDateRange = (data['dateRange'] as List<dynamic>)
            .map((date) => DateTime.parse(date.toString())) // ✅ Convert back to List<DateTime>
            .toList();
        return AddTaskModel.fromJson({...data, 'dateRange': parsedDateRange});
      }).toList(),
    );
  }

  /// **Update Task in Firestore**
  Future<void> updateTask({
    required BuildContext context,
    required String taskId,
    required Map<String, dynamic> updatedData,
  }) async {
    try {
      if (updatedData.containsKey('dateRange')) {
        updatedData['dateRange'] = (updatedData['dateRange'] as List<DateTime>)
            .map((date) => date.toIso8601String()) // ✅ Convert List<DateTime> to List<String>
            .toList();
      }
      await _firestore.collection('tasks').doc(taskId).update(updatedData);
    } on FirebaseException catch (e) {
      throw _handleFirestoreError(context, e);
    }
  }

  /// **Delete Task from Firestore**
  Future<void> deleteTask({
    required BuildContext context,
    required String taskId,
  }) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
    } on FirebaseException catch (e) {
      throw _handleFirestoreError(context, e);
    }
  }

  /// **Handle Firestore Errors**
  String _handleFirestoreError(BuildContext context, FirebaseException e) {
    final appLocalization = AppLocalizations.of(context);

    switch (e.code) {
      case 'permission-denied':
        return appLocalization.permissionDenied;
      case 'not-found':
        return appLocalization.documentNotFound;
      case 'unavailable':
        return appLocalization.serviceUnavailable;
      default:
        return appLocalization.unexpectedError;
    }
  }
}
