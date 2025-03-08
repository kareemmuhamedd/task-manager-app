import 'package:equatable/equatable.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_details_entity.dart';

class TodoEntity extends Equatable {
  final List<TodoDetailsEntity>? todos;
  final int? total;
  final int? skip;
  final int? limit;

  const TodoEntity({
    this.todos,
    this.total,
    this.skip,
    this.limit,
  });

  TodoEntity copyWith({
    List<TodoDetailsEntity>? todos,
    int? total,
    int? skip,
    int? limit,
  }) {
    return TodoEntity(
      todos: todos ?? this.todos,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }

  @override
  List<Object?> get props => [todos, total, skip, limit];
}
