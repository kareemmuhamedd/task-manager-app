import 'package:equatable/equatable.dart';

class TodoDetailsEntity extends Equatable {
  final int? id;
  final String? todo;
  final bool completed;
  final int? userId;

  const TodoDetailsEntity({
    this.id,
    this.todo,
    required this.completed,
    this.userId,
  });

  TodoDetailsEntity copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
  }) {
    return TodoDetailsEntity(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [id, todo, completed, userId];
}
