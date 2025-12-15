class ProjectModel {
  final int projectId;
  final String projectName;
  final String projectDescription;
  final DateTime createdAt;
  final List<int> tasksIds;

  ProjectModel({
    required this.projectId,
    required this.projectName,
    required this.projectDescription,
    required this.createdAt,
    this.tasksIds = const [],
  });


  ProjectModel addTask(int taskId) {
    return ProjectModel(
      projectId: projectId,
      projectName: projectName,
      projectDescription: projectDescription,
      createdAt: createdAt,
      tasksIds: [...tasksIds, taskId],
    );
  }
}
