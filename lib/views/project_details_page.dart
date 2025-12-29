import 'package:daily_dash/controllers/task%20cubit/cubit/task_cubit_cubit.dart';
import 'package:daily_dash/controllers/task%20cubit/cubit/task_cubit_state.dart';
import 'package:daily_dash/models/project_model.dart';
import 'package:daily_dash/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectModel project;
  const ProjectDetailsScreen({super.key, required this.project});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().loadTasksByProject(widget.project.projectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.project.projectName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.project.projectDescription ?? 'No description provided.',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 40),
            const Text(
              'Tasks List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<TaskCubit, TaskCubitState>(
                builder: (context, state) {
                  if (state is TaskCubitLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TaskCubitSuccess) {
                    if (state.entries.isEmpty) {
                      return const Center(child: Text("No tasks for this project."));
                    }
                    return ListView.builder(
                      itemCount: state.entries.length,
                      itemBuilder: (context, index) {
                        final entry = state.entries[index];
                        final task = entry.value;
                        final key = entry.key;

                        return Card(
                          child: ListTile(
                            title: Text(
                              task.taskTitle,
                              style: TextStyle(
                                decoration: task.isDone ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            leading: Checkbox(
                              value: task.isDone,
                              onChanged: (_) {
                                context.read<TaskCubit>().toggleTaskDone(key);
                              },
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => context.read<TaskCubit>().deleteTask(key, widget.project.projectId),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is TaskCubitFailure) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          controller: taskController,
          decoration: const InputDecoration(hintText: 'Enter task title...'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (taskController.text.isNotEmpty) {
                final newTask = TaskModel(
                  projectId: widget.project.projectId,
                  taskTitle: taskController.text,
                  isDone: false,
                );
                context.read<TaskCubit>().addTask(newTask);
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
