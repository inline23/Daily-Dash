class ProjectModel {
  final String projectId;
  final String projectName;
  final String projectDescription;
  final DateTime createdAt;

  ProjectModel({
    required this.projectId,
    required this.projectName,
    required this.projectDescription,
    required this.createdAt,
  });


  ProjectModel addTask(int taskId) {
    return ProjectModel(
      projectId: projectId,
      projectName: projectName,
      projectDescription: projectDescription,
      createdAt: createdAt,
    );
  }
}
