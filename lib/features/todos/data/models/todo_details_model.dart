import 'package:json_annotation/json_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'todo_details_model.g.dart';

@JsonSerializable()
class TodoDetailsModel extends HiveObject with EquatableMixin {
  @IntToStringConverter()
  final int? id;
  final String? todo;
  final bool completed;
  final int? userId;

  TodoDetailsModel({
    this.id,
    this.todo,
    required this.completed,
    this.userId,
  });

  TodoDetailsModel copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
  }) {
    return TodoDetailsModel(
      id: id ?? this.id,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
      todo: todo ?? this.todo,
    );
  }

  @override
  factory TodoDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$TodoDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoDetailsModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        todo,
        completed,
        userId,
      ];
}

class IntToStringConverter implements JsonConverter<int?, dynamic> {
  const IntToStringConverter();

  @override
  int? fromJson(dynamic json) {
    if (json is int) {
      return json;
    } else if (json is String) {
      return int.tryParse(json);
    }
    return null;
  }

  @override
  String toJson(int? object) {
    return object?.toString() ?? '';
  }
}
