import 'package:daily_dash/models/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskTypeAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 1;

  @override
  TaskModel read(BinaryReader reader) {
    return TaskModel(
      projectId: reader.readString(),
      taskTitle: reader.readString(),
      isDone: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeString(obj.projectId);
    writer.writeString(obj.taskTitle);
    writer.writeBool(obj.isDone);
  }
}
