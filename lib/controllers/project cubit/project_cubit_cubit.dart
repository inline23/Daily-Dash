import 'package:daily_dash/hive_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/project_model.dart';
import 'project_cubit_state.dart';

class ProjectCubit extends Cubit<ProjectCubitState> {
  ProjectCubit() : super(ProjectCubitInitial());

  Box<ProjectModel> get _projectBox =>
      Hive.box<ProjectModel>(HiveConstants.projectsBox);
// ======================= Get projects
  void loadProjects() {
    try {
      emit(ProjectCubitLoading());
      final projects = _projectBox.values.toList();
      emit(ProjectCubitSuccess(projects: projects));
    } catch (e) {
      emit(ProjectCubitFailure(errorMessage: e.toString()));
    }
  }

  // ======================= Add project
  void addProject(ProjectModel project) {
    try {
      emit(ProjectCubitLoading());
      _projectBox.put(project.projectId, project);
      loadProjects();
    } catch (e) {
      emit(ProjectCubitFailure(errorMessage: e.toString()));
    }
  }


  // ======================= Delete project
  void deleteProject(int projectId) {
    try {
      emit(ProjectCubitLoading());

      _projectBox.delete(projectId);

      loadProjects();
    } catch (e) {
      emit(ProjectCubitFailure(errorMessage: e.toString()));
    }
  }

  // =======================
  // Add taskId to project
  // =======================
  void addTaskToProject({
    required int projectId,
    required int taskId,
  }) {
    try {
      emit(ProjectCubitLoading());

      final project = _projectBox.get(projectId);

      if (project == null) {
        emit(ProjectCubitFailure(errorMessage: 'Project not found'));
        return;
      }

      final updatedProject = project.addTask(taskId);

      _projectBox.put(projectId, updatedProject);

      loadProjects();
    } catch (e) {
      emit(ProjectCubitFailure(errorMessage: e.toString()));
    }
  }
}
