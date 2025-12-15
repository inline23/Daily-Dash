import 'package:daily_dash/models/task_model.dart';
import 'package:hive_flutter/adapters.dart';

class TaskTypeAdapter extends TypeAdapter<TaskModel> {
  @override
  TaskModel read(BinaryReader reader) {
    return TaskModel(
      projectId: reader.readInt(),
      taskId: reader.readInt(),
      taskTitle: reader.readString(),
      isDone: reader.readBool(),
    );
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeInt(obj.projectId);
    writer.writeInt(obj.taskId);
    writer.writeString(obj.taskTitle);
    writer.writeBool(obj.isDone); 
  }
}
