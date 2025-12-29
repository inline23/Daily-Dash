import 'package:daily_dash/models/project_model.dart';
import 'package:flutter/material.dart';

class LatestProjectCard extends StatelessWidget {
  const LatestProjectCard({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(colors: [Colors.lightBlue, Colors.blueAccent]),
      ),
      child: Container(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // خليهم يبدأوا من الشمال
          children: [
            Text(
              project.projectName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Divider(), // خط فاصل بسيط
            Text(
              project.projectDescription,
              style: TextStyle(fontSize: 14, color: Colors.grey[300]),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "Created At: ${project.createdAt.day}/${project.createdAt.month}/${project.createdAt.year}",
                style: TextStyle(fontSize: 12, color: Colors.grey[300]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
