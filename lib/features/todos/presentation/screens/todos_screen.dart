import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_tasks_app/app/di/init_dependencies.dart';
import 'package:management_tasks_app/app/routes/app_routes.dart';
import 'package:management_tasks_app/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:management_tasks_app/shared/utilities/snack_bars/custom_snack_bar.dart';

import '../widgets/todo_app_bar_widget.dart';

enum TodoAction { delete, update }

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<TodosBloc>()
        ..add(const PaginatedTodosEventRequested(limit: 10, skip: 0)),
      child: const TodosView(),
    );
  }
}

class TodosView extends StatefulWidget {
  const TodosView({super.key});

  @override
  TodosViewState createState() => TodosViewState();
}

class TodosViewState extends State<TodosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTodoAppBar(context),
      body: BlocConsumer<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state.status == TodosStatus.error) {
            showCustomSnackBar(
              context,
              state.message,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.status == TodosStatus.loading && state.todos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: state.hasReachedMax
                ? state.todos.length
                : state.todos.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.todos.length) {
                return state.hasReachedMax
                    ? const SizedBox.shrink()
                    : const Center(child: CircularProgressIndicator());
              }
              // Trigger load when 5 items from the end
              if (index == state.todos.length - 5 &&
                  !state.hasReachedMax &&
                  state.status != TodosStatus.loading) {
                context.read<TodosBloc>().add(PaginatedTodosEventRequested(
                      limit: 10,
                      skip: state.todos.length,
                    ));
              }
              final todo = state.todos[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (value) {
                      context.read<TodosBloc>().add(
                            UpdateTodoEventRequested(
                              todo: todo.copyWith(completed: value),
                              todoId: todo.id!,
                            ),
                          );
                    },
                    activeColor: Colors.indigo,
                    shape: const CircleBorder(),
                  ),
                  title: Text(
                    todo.todo ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      decoration: todo.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: todo.completed ? Colors.grey : Colors.black87,
                    ),
                  ),
                  trailing: PopupMenuButton<TodoAction>(
                    icon: const Icon(Icons.more_vert, color: Colors.grey),
                    onSelected: (action) {
                      if (action == TodoAction.delete) {
                        _showDeleteConfirmationDialog(context, todo.id!);
                      } else if (action == TodoAction.update) {
                        context.pushNamed(
                          AppRoutesPaths.kEditTodoScreen,
                          extra: todo,
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem<TodoAction>(
                        value: TodoAction.update,
                        child: ListTile(
                          leading: Icon(Icons.edit, color: Colors.blue),
                          title: Text("Update"),
                        ),
                      ),
                      const PopupMenuItem<TodoAction>(
                        value: TodoAction.delete,
                        child: ListTile(
                          leading: Icon(Icons.delete, color: Colors.red),
                          title: Text("Delete"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoutesPaths.kAddTodosScreen);
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int todoId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete Todo"),
        content: const Text("Are you sure you want to delete this todo?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context
                  .read<TodosBloc>()
                  .add(DeleteTodoEventRequested(id: todoId));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
