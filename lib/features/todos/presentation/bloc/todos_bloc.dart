import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_details_entity.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_entity.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/create_todo_usecase.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/get_pagination_todos_usecase.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/get_random_todo_usecase.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/get_todos_usecase.dart';

import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/get_todo_by_id_usecase.dart';
import '../../domain/usecases/get_user_todos_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';

part 'todos_event.dart';

part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({
    required GetPaginationTodosUseCase getPaginationTodosUseCase,
    required CreateTodoUseCase createTodoUseCase,
    required DeleteTodoUseCase deleteTodoUseCase,
    required UpdateTodoUseCase updateTodoUseCase,
    required GetUserTodosUseCase getUserTodosUseCase,
    required GetRandomTodoUseCase getRandomTodoUseCase,
    required GetTodoByIdUseCase getTodosByUserIdUseCase,
    required GetTodosUseCase getTodosUseCase,
  })  : _getPaginationTodosUseCase = getPaginationTodosUseCase,
        _createTodoUseCase = createTodoUseCase,
        _deleteTodoUseCase = deleteTodoUseCase,
        _updateTodoUseCase = updateTodoUseCase,
        _getUserTodosUseCase = getUserTodosUseCase,
        _getRandomTodoUseCase = getRandomTodoUseCase,
        _getTodosByUserIdUseCase = getTodosByUserIdUseCase,
        _getTodosUseCase = getTodosUseCase,
        super(const TodosState.initial()) {
    on<PaginatedTodosEventRequested>(_onPaginatedTodosEventRequested);
    on<UpdateTodoEventRequested>(_onUpdateTodoEventRequested);
    on<DeleteTodoEventRequested>(_onDeleteTodoEventRequested);
    on<CreateTodoEventRequested>(_onCreateTodoEventRequested);
  }

  final GetPaginationTodosUseCase _getPaginationTodosUseCase;
  final CreateTodoUseCase _createTodoUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final GetUserTodosUseCase _getUserTodosUseCase;
  final GetRandomTodoUseCase _getRandomTodoUseCase;
  final GetTodoByIdUseCase _getTodosByUserIdUseCase;
  final GetTodosUseCase _getTodosUseCase;

  Future<void> _onPaginatedTodosEventRequested(
    PaginatedTodosEventRequested event,
    Emitter<TodosState> emit,
  ) async {
    if (state.hasReachedMax || state.status == TodosStatus.loading) return;

    emit(state.copyWith(status: TodosStatus.loading));

    final result = await _getPaginationTodosUseCase.call(
      GetPaginationTodosParams(
        limit: event.limit,
        skip: event.skip,
      ),
    );

    result.fold(
      (error) => emit(state.copyWith(
        status: TodosStatus.error,
        message: error.message,
      )),
      (todosResult) {
        final newTodos = todosResult.todos;
        final total = todosResult.total;

        final updatedTodos =
            event.skip == 0 ? newTodos : [...state.todos, ...?newTodos];

        final hasReachedMax = updatedTodos!.length >= total!;

        emit(state.copyWith(
          status: TodosStatus.loaded,
          todos: updatedTodos,
          total: total,
          hasReachedMax: hasReachedMax,
        ));
      },
    );
  }

  Future<void> _onUpdateTodoEventRequested(
    UpdateTodoEventRequested event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(status: TodosStatus.loading));

    final result = await _updateTodoUseCase.call(
      UpdateTodoParams(
        completed: event.todo.completed,
        todo: event.todo,
        todoId: event.todoId,
      ),
    );
    result.fold(
      (error) => emit(state.copyWith(
        status: TodosStatus.error,
        message: error.message,
      )),
      (todo) {
        final updatedTodos = state.todos.map((e) {
          if (e.id == todo.id) {
            return todo;
          }
          return e;
        }).toList();

        emit(state.copyWith(
          status: TodosStatus.loaded,
          todos: updatedTodos,
        ));
      },
    );
  }

  Future<void> _onDeleteTodoEventRequested(
    DeleteTodoEventRequested event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(status: TodosStatus.loading));

    final result = await _deleteTodoUseCase.call(
      DeleteTodoParams(id: event.id),
    );

    result.fold(
      (error) => emit(state.copyWith(
        status: TodosStatus.error,
        message: error.message,
      )),
      (_) {
        final updatedTodos =
            state.todos.where((e) => e.id != event.id).toList();

        emit(state.copyWith(
          status: TodosStatus.loaded,
          todos: updatedTodos,
        ));
      },
    );
  }

  Future<void> _onCreateTodoEventRequested(
    CreateTodoEventRequested event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(status: TodosStatus.loading));

    final result = await _createTodoUseCase.call(
      CreateTodoParams(
        todo: event.todo.todo,
        userId: event.todo.userId,
        completed: event.todo.completed,
      ),
    );
    result.fold(
      (error) => emit(state.copyWith(
        status: TodosStatus.error,
        message: error.message,
      )),
      (todo) {
        final updatedTodos = [todo, ...state.todos];

        emit(state.copyWith(
          status: TodosStatus.taskCreated,
          todos: updatedTodos,
          message: 'Todo created successfully',
        ));
      },
    );
  }
}
