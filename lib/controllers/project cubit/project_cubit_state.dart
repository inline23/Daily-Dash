
import 'package:daily_dash/models/project_model.dart';

abstract class ProjectCubitState {}

final class ProjectCubitInitial extends ProjectCubitState {}
final class ProjectCubitLoading extends ProjectCubitState {}
final class ProjectCubitSuccess extends ProjectCubitState {
  List<ProjectModel> projects; 
  ProjectCubitSuccess({required this.projects});
}
final class ProjectCubitFailure extends ProjectCubitState {
  String errorMessage;
  ProjectCubitFailure({required this.errorMessage});
}
