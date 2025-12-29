import 'package:daily_dash/models/task_model.dart';


abstract class TaskCubitState {}

class TaskCubitInitial extends TaskCubitState {}

class TaskCubitLoading extends TaskCubitState {}

class TaskCubitSuccess extends TaskCubitState {
  final List<MapEntry<dynamic, TaskModel>> entries;

  TaskCubitSuccess({required this.entries});
}

class TaskCubitFailure extends TaskCubitState {
  final String errorMessage;

  TaskCubitFailure({required this.errorMessage});
}
