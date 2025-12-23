import 'package:daily_dash/controllers/project%20cubit/project_cubit_cubit.dart';
import 'package:daily_dash/controllers/project%20cubit/project_cubit_state.dart';
import 'package:daily_dash/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProjectScreen extends StatefulWidget {
  // إضافة هذا السطر لاستقبال دالة التغيير من الـ HomePage
  final VoidCallback? onProjectAdded;
  const AddProjectScreen({super.key, this.onProjectAdded});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}
// ... (الواردات كما هي)

class _AddProjectScreenState extends State<AddProjectScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // استخدم GestureDetector هنا لتغطية الشاشة بالكامل
    return GestureDetector(
      onTap: () {
        // هذا السطر يقوم بإغلاق الكيبورد وإزالة التركيز (Focus)
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // أضفنا SingleChildScrollView لتجنب أخطاء تجاوز الحجم عند ظهور الكيبورد
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                centerTitle(), // دالة مساعدة لتنظيم الكود
                const SizedBox(height: 40),
                customTextField(
                  controller: nameController,
                  label: 'Project Name',
                ),
                const SizedBox(height: 15),
                customTextField(
                  controller: descController,
                  label: 'Project Description', // قمت بتعديل الاسم هنا
                  maxLines: 3,
                ),
                const SizedBox(height: 30),
                buildBlocConsumer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- دوال مساعدة (Helper Widgets) لتحسين شكل الكود ---

  Widget centerTitle() {
    return const Center(
      child: Text(
        'Add Project',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget customTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget buildBlocConsumer() {
    return BlocConsumer<ProjectCubit, ProjectCubitState>(
      listener: (context, state) {
        if (state is ProjectCubitSuccess) {
          nameController.clear();
          descController.clear();
          if (widget.onProjectAdded != null) {
            widget.onProjectAdded!();
          } else {
            Navigator.pop(context);
          }
        } else if (state is ProjectCubitFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        if (state is ProjectCubitLoading) {
          return const CircularProgressIndicator();
        }
        return InkWell(
          onTap: () {
            if (nameController.text.isNotEmpty) {
              final newProject = ProjectModel(
                projectId: DateTime.now().millisecondsSinceEpoch.toString(),
                projectName: nameController.text,
                projectDescription: descController.text,
                createdAt: DateTime.now(),
              );
              context.read<ProjectCubit>().addProject(newProject);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [Colors.lightBlue, Colors.blueAccent],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Save Project', style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      },
    );
  }
}
