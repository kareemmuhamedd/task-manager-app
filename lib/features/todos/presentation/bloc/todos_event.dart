part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

final class PaginatedTodosEventRequested extends TodosEvent {
  final int skip;
  final int limit;

  const PaginatedTodosEventRequested({
    required this.skip,
    required this.limit,
  });

  @override
  List<Object> get props => [skip, limit];
}

final class UpdateTodoEventRequested extends TodosEvent {
  final TodoDetailsEntity todo;
  final int todoId;

  const UpdateTodoEventRequested({
    required this.todo,
    required this.todoId,
  });

  @override
  List<Object> get props => [todo, todoId];
}

final class DeleteTodoEventRequested extends TodosEvent {
  final int id;

  const DeleteTodoEventRequested({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

final class CreateTodoEventRequested extends TodosEvent {
  final TodoDetailsEntity todo;

  const CreateTodoEventRequested({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}
