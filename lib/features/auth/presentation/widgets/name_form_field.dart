import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_tasks_app/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../../shared/widgets/custom_text_form_field.dart';

class PhoneFormField extends StatefulWidget {
  const PhoneFormField({super.key});

  @override
  State<PhoneFormField> createState() => _PhoneFormFieldState();
}

class _PhoneFormFieldState extends State<PhoneFormField> {
  late TextEditingController _userNameController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _userNameController.addListener(() {
      if (_userNameController.text.isNotEmpty) {
        context.read<AuthCubit>().onUserNameChanged(
              _userNameController.text,
            );
      }
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userNameError = context.select(
      (AuthCubit cubit) => cubit.state.userName.errorMessage,
    );
    return CustomTextFormField(
      errorText: userNameError,
      prefixIcon: const Icon(Icons.person),
      controller: _userNameController,
    );
  }
}
