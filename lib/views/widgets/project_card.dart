
import 'package:daily_dash/controllers/project%20cubit/project_cubit_cubit.dart';
import 'package:daily_dash/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row( // استخدمنا Row عشان نحط الاسم وجنبه زرار الحذف
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    project.projectName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // إظهار Dialog تأكيد قبل الحذف (أفضل لتجربة المستخدم)
                    _showDeleteDialog(context);
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
            const Divider(),
            Text(project.projectDescription, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "Created At: ${project.createdAt.day}/${project.createdAt.month}/${project.createdAt.year}",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة لإظهار تنبيه التأكيد
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Project'),
        content: const Text('Are you sure you want to delete this project?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // استدعاء الـ Cubit للحذف باستخدام الـ ID
              context.read<ProjectCubit>().deleteProject(project.projectId);
              Navigator.pop(dialogContext);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}