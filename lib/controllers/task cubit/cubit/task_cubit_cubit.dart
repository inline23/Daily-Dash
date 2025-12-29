import 'package:daily_dash/controllers/task%20cubit/cubit/task_cubit_state.dart';
import 'package:daily_dash/hive_constants.dart';
import 'package:daily_dash/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskCubit extends Cubit<TaskCubitState> {
  TaskCubit() : super(TaskCubitInitial());

  Box<TaskModel> get _taskBox =>
      Hive.box<TaskModel>(HiveConstants.tasksBox);

  // Load tasks by projectId
  void loadTasksByProject(String projectId) {
    emit(TaskCubitLoading());

    final tasks = _taskBox.toMap().entries
        .where((e) => e.value.projectId == projectId)
        .toList();

    emit(TaskCubitSuccess(entries: tasks));
  }

  // Add task
  void addTask(TaskModel task) {
    _taskBox.add(task);
    loadTasksByProject(task.projectId);
  }

  // Toggle done
  void toggleTaskDone(int key) {
    final task = _taskBox.get(key)!;
    final updated = task.copyWith(isDone: !task.isDone);
    _taskBox.put(key, updated);
    loadTasksByProject(updated.projectId);
  }

  // Delete task
  void deleteTask(int key , String projectId) {
    _taskBox.delete(key);
    loadTasksByProject(projectId);
  }
}
