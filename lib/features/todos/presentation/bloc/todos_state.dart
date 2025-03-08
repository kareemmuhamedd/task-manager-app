part of 'todos_bloc.dart';

enum TodosStatus {
  initial,
  loading,
  loaded,
  taskCreated,
  error,
}

class TodosState extends Equatable {
  const TodosState._({
    required this.status,
    required this.todos,
    required this.message,
    required this.total,
    required this.hasReachedMax,
  });

  const TodosState.initial()
      : this._(
          status: TodosStatus.initial,
          todos: const [],
          message: '',
          total: 0,
          hasReachedMax: false,
        );

  final TodosStatus status;
  final List<TodoDetailsEntity> todos;
  final String message;
  final int total;
  final bool hasReachedMax;

  TodosState copyWith({
    TodosStatus? status,
    List<TodoDetailsEntity>? todos,
    String? message,
    int? total,
    bool? hasReachedMax,
  }) {
    return TodosState._(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      message: message ?? this.message,
      total: total ?? this.total,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, todos, message];
}
