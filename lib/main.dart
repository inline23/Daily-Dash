import 'package:daily_dash/controllers/project%20cubit/project_cubit_cubit.dart';
import 'package:daily_dash/controllers/task%20cubit/cubit/task_cubit_cubit.dart';
import 'package:daily_dash/hive_constants.dart';
import 'package:daily_dash/models/project_model.dart';
import 'package:daily_dash/models/project_type_adapter.dart';
import 'package:daily_dash/models/task_model.dart';
import 'package:daily_dash/models/task_type_adapter.dart';
import 'package:daily_dash/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ProjectTypeAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  await Hive.openBox<ProjectModel>(HiveConstants.projectsBox);
  await Hive.openBox<TaskModel>(HiveConstants.tasksBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [                                    // call load project before init home
        BlocProvider(create: (context) => ProjectCubit()..loadProjects()),
        BlocProvider(create: (context) => TaskCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
