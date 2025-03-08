import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_tasks_app/app/di/init_dependencies.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_details_entity.dart';

import '../../../../shared/utilities/local_storage/secure_storage_service.dart';
import '../../../../shared/utilities/snack_bars/custom_snack_bar.dart';
import '../bloc/todos_bloc.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<TodosBloc>(),
      child: const AddTodoBody(),
    );
  }
}

class AddTodoBody extends StatefulWidget {
  const AddTodoBody({super.key});

  @override
  State<AddTodoBody> createState() => _AddTodoBodyState();
}

class _AddTodoBodyState extends State<AddTodoBody> {
  final _formKey = GlobalKey<FormState>();
  final _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Add New Todo', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.indigo,
      ),
      body: BlocConsumer<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state.status == TodosStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          } else if (state.status == TodosStatus.taskCreated) {
            showCustomSnackBar(
              context,
              state.message,
              isError: false,
            );
            _formKey.currentState?.reset();
            context.pop();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _todoController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Todo Description',
                      hintText: 'Enter your todo description',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.task_rounded),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) => value!.isEmpty
                        ? 'Please enter a todo description'
                        : null,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: state.status == TodosStatus.loading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                final userId = await SecureStorageHelper
                                    .instance
                                    .getString('user_id');
                                final newTodo = TodoDetailsEntity(
                                  todo: _todoController.text,
                                  userId: int.parse(userId??'1'),
                                  completed: false,
                                );
                                context.read<TodosBloc>().add(
                                      CreateTodoEventRequested(todo: newTodo),
                                    );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: state.status == TodosStatus.loading
                          ? Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(2),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Icon(Icons.add_task_rounded),
                      label: Text(
                        state.status == TodosStatus.loading
                            ? 'Creating...'
                            : 'Create Todo',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
