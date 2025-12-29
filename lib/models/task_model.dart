
class TaskModel {
  final String projectId;
  final String taskTitle;
  final bool isDone;

  TaskModel({
    required this.projectId,
    required this.taskTitle,
    this.isDone = false,
  });

  TaskModel copyWith({
    String? projectId,
    String? taskTitle,
    bool? isDone,
  }) {
    return TaskModel(
      projectId: projectId ?? this.projectId,
      taskTitle: taskTitle ?? this.taskTitle,
      isDone: isDone ?? this.isDone,
    );
  }
}
