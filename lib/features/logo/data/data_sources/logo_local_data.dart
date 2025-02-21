import 'package:hive/hive.dart';
import 'package:tasky/features/logo/data/model/logo_model_hive.dart';

abstract class LogoLocalDataSource {
  Future<List<LogoModelHive>> getTasks();
  Future<void> saveTask(List<LogoModelHive> task);
  Future<void> deleteTask(String id);
}

class LocalDataSourceImpl implements LogoLocalDataSource {
  final Box<LogoModelHive> taskBox;

  LocalDataSourceImpl(this.taskBox);

  @override
  Future<List<LogoModelHive>> getTasks() async {
    return taskBox.values.toList();
  }

  @override
  Future<void> saveTask(List<LogoModelHive> tasks) async {
    final taskMap = {for (var task in tasks) task.id: task};
    await taskBox.putAll(taskMap);
  }

  @override
  Future<void> deleteTask(String id) async {
    await taskBox.delete(id);
  }
}
