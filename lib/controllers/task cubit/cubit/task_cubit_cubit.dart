import 'package:daily_dash/controllers/task%20cubit/cubit/task_cubit_state.dart';
import 'package:daily_dash/hive_constants.dart';
import 'package:daily_dash/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskCubit extends Cubit<TaskCubitState> {
  TaskCubit() : super(TaskCubitInitial());

  Box<TaskModel> get _taskBox => Hive.box<TaskModel>(HiveConstants.tasksBox);

  // =======================
  // Load tasks by projectId
  // =======================
  void loadTasksByProject(String projectId) {
    try {
      emit(TaskCubitLoading());

      final tasks = _taskBox.values
          .where((task) => task.projectId == projectId)
          .toList();

      emit(TaskCubitSuccess(tasks: tasks));
    } catch (e) {
      emit(TaskCubitFailure(errorMessage: e.toString()));
    }
  }

  // =======================
  // Add new task
  // =======================
  void addTask(TaskModel task) {
    try {
      emit(TaskCubitLoading());

      _taskBox.put(task.taskId, task);

      loadTasksByProject(task.projectId);
    } catch (e) {
      emit(TaskCubitFailure(errorMessage: e.toString()));
    }
  }

  // =======================
  // Toggle task done
  // =======================
  void toggleTaskDone(String taskId) {
    try {
      emit(TaskCubitLoading());

      final task = _taskBox.get(taskId);

      if (task == null) {
        emit(TaskCubitFailure(errorMessage: 'Task not found'));
        return;
      }

      final updatedTask = TaskModel(
        projectId: task.projectId,
        taskId: task.taskId,
        taskTitle: task.taskTitle,
        isDone: !task.isDone,
      );

      _taskBox.put(taskId, updatedTask);

      loadTasksByProject(task.projectId);
    } catch (e) {
      emit(TaskCubitFailure(errorMessage: e.toString()));
    }
  }

  // =======================
  // Delete task
  // =======================
  void deleteTask(String taskId) {
    try {
      emit(TaskCubitLoading());

      final task = _taskBox.get(taskId);

      if (task == null) {
        emit(TaskCubitFailure(errorMessage: 'Task not found'));
        return;
      }

      _taskBox.delete(taskId);

      loadTasksByProject(task.projectId);
    } catch (e) {
      emit(TaskCubitFailure(errorMessage: e.toString()));
    }
  }
}
