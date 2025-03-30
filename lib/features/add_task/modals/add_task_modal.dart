class AddTaskModel {
  final String taskId;
  final String userUid;
  final String taskName;
  final String taskDescription;
  final List<String> dateRange; // ✅ Changed from String to List<String>
  final bool notificationAlert;
  final String taskStatus;
  final String taskPriority;

  AddTaskModel({
    required this.taskId,
    required this.userUid,
    required this.taskName,
    required this.taskDescription,
    required this.dateRange, // ✅ List<String> for Firestore compatibility
    required this.notificationAlert,
    required this.taskStatus,
    required this.taskPriority,
  });

  /// **Convert Model to JSON**
  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'userUid': userUid,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'dateRange': dateRange, // ✅ No need to convert, it's already List<String>
      'notificationAlert': notificationAlert,
      'taskStatus': taskStatus,
      'taskPriority': taskPriority,
    };
  }

  /// **Convert JSON to Model**
  factory AddTaskModel.fromJson(Map<String, dynamic> json) {
    return AddTaskModel(
      taskId: json['taskId'] as String,
      userUid: json['userUid'] as String,
      taskName: json['taskName'] as String,
      taskDescription: json['taskDescription'] as String,
      dateRange: List<String>.from(json['dateRange'] as List<dynamic>), // ✅ Convert Firestore List<dynamic> to List<String>
      notificationAlert: json['notificationAlert'] as bool,
      taskStatus: json['taskStatus'] as String,
      taskPriority: json['taskPriority'] as String,
    );
  }
}
