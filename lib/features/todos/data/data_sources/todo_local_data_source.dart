// profile_local_data_source.dart
import 'package:hive_ce/hive.dart';

import '../models/todo_model.dart';


abstract class TodoLocalDataSource {
  Future<TodoModel?> getTodos();

  Future<void> saveTodos(TodoModel profile);

  Future<void> clearTodos();
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Box<TodoModel> profileBox;

  TodoLocalDataSourceImpl(this.profileBox);

  @override
  Future<TodoModel?> getTodos() async {
    if (profileBox.isNotEmpty) {
      return profileBox.getAt(0);
    }
    return null;
  }

  @override
  Future<void> saveTodos(TodoModel profile) async {
    await profileBox.clear();
    await profileBox.add(profile);
  }

  @override
  Future<void> clearTodos() async {
    await profileBox.clear();
  }
}
