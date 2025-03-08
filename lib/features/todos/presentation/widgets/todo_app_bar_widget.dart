import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes/app_routes.dart';

AppBar buildTodoAppBar(BuildContext context) {
  return AppBar(
    title: const Text(
      'Todo List',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.indigo,
    elevation: 0,
    actions: [
      IconButton(
        icon: const Icon(
          Icons.account_circle,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          context.pushNamed(AppRoutesPaths.kProfileScreen);
        },
      ),
    ],
  );
}