import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:management_tasks_app/features/todos/data/models/todo_details_model.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel extends HiveObject {
  final List<TodoDetailsModel>? todos;
  final int? total;
  final int? skip;
  final int? limit;

   TodoModel({
    this.todos,
    this.total,
    this.skip,
    this.limit,
  });

  @override
  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
