class TaskModel {
  final String projectId;
  final int taskId;
  final String taskTitle;
  final bool isDone;

  TaskModel({
    required this.projectId,
    required this.taskId,
    required this.taskTitle,
    this.isDone = false,
  });

  TaskModel copyWith({
    String? projectId,
    int? taskId,
    String? taskTitle,
    bool? isDone,
  }) {
    return TaskModel(
      projectId: projectId ?? this.projectId,
      taskId: taskId ?? this.taskId,
      taskTitle: taskTitle ?? this.taskTitle,
      isDone: isDone ?? this.isDone,
    );
  }
}