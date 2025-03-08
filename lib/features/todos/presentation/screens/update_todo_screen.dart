import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_tasks_app/app/di/init_dependencies.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_details_entity.dart';

import '../bloc/todos_bloc.dart';

class EditTodoScreen extends StatelessWidget {
  const EditTodoScreen({super.key, required this.todo});

  final TodoDetailsEntity todo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<TodosBloc>(),
      child: EditTodoBody(todo: todo),
    );
  }
}

class EditTodoBody extends StatefulWidget {
  const EditTodoBody({super.key, required this.todo});

  final TodoDetailsEntity todo;

  @override
  State<EditTodoBody> createState() => _EditTodoBodyState();
}

class _EditTodoBodyState extends State<EditTodoBody> {
  late final TextEditingController _todoController;
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _todoController = TextEditingController(text: widget.todo.todo);
    _isCompleted = widget.todo.completed;
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    if (_todoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todo description cannot be empty')),
      );
      return;
    }

    final updatedTodo = widget.todo.copyWith(
      todo: _todoController.text,
      completed: _isCompleted,
    );

    context.read<TodosBloc>().add(
          UpdateTodoEventRequested(
            todo: updatedTodo,
            todoId: updatedTodo.id!,
          ),
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _handleUpdate,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _todoController,
              decoration: const InputDecoration(
                labelText: 'Todo Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Completed'),
              value: _isCompleted,
              onChanged: (bool value) {
                setState(() {
                  _isCompleted = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
