class TaskModel {
  final int projectId;
  final int taskId;
  final String taskTitle;
  final bool isDone;

  TaskModel({
    required this.projectId,
    required this.taskId,
    required this.taskTitle,
    this.isDone = false,
  });
}
