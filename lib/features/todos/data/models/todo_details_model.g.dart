// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoDetailsModel _$TodoDetailsModelFromJson(Map<String, dynamic> json) =>
    TodoDetailsModel(
      id: const IntToStringConverter().fromJson(json['id']),
      todo: json['todo'] as String?,
      completed: json['completed'] as bool,
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TodoDetailsModelToJson(TodoDetailsModel instance) =>
    <String, dynamic>{
      'id': const IntToStringConverter().toJson(instance.id),
      'todo': instance.todo,
      'completed': instance.completed,
      'userId': instance.userId,
    };
