import 'package:daily_dash/models/project_model.dart';
import 'package:daily_dash/views/project_details_page.dart';
import 'package:daily_dash/views/widgets/latest_project_card.dart';
import 'package:daily_dash/views/widgets/project_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.projects});

  final List<ProjectModel> projects;
  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.folder_open_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No projects available right now',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    // لو في مشاريع
    final lastProject = projects.last;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 20)),

        SliverToBoxAdapter(
          child: Center(
            child: Text(
              'Last Project Added',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: LatestProjectCard(project: lastProject),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Text(
              'All Projects',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(
            thickness: 1,
            indent: 17,
            endIndent: 17,
            color: Colors.grey.shade300,
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return InkWell(
              child: ProjectCard(project: projects[index]),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProjectDetailsScreen(project: projects[index]),
                ),
              ),
            );
          }, childCount: projects.length),
        ),
      ],
    );
  }
}
