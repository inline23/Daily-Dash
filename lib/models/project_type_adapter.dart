import 'package:daily_dash/models/project_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProjectTypeAdapter extends TypeAdapter<ProjectModel> {
  @override
  ProjectModel read(BinaryReader reader) {
    return ProjectModel(
      projectId: reader.readInt(),
      projectName: reader.readString(),
      projectDescription: reader.readString(),
      createdAt: DateTime.parse(reader.readString()),
      tasksIds: reader.readList().cast<int>(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, ProjectModel obj) {
    writer.writeInt(obj.projectId);
    writer.writeString(obj.projectName);
    writer.writeString(obj.projectDescription);
    writer.writeString(obj.createdAt.toIso8601String());
    writer.writeList(obj.tasksIds);
  }
}
