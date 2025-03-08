import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_tasks_app/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/widgets/custom_text_form_field.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({super.key});

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordController.addListener(() {
      if (_passwordController.text.isNotEmpty) {
        context.read<AuthCubit>().onPasswordChanged(_passwordController.text);
      }
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordError = context.select(
      (AuthCubit cubit) => cubit.state.password.errorMessage,
    );
    final passwordVisible = context.select(
      (AuthCubit cubit) => cubit.state.showPassword,
    );
    return CustomTextFormField(
      errorText: passwordError,
      contentPadding: const EdgeInsets.only(left: 15),
      hintText: 'Password...',
      suffixIcon: GestureDetector(
        onTap: () {
          context.read<AuthCubit>().changePasswordVisibility();
        },
        child: Icon(
          passwordVisible ? Icons.visibility : Icons.visibility_off,
          color: AppColors.borderGreyColor,
        ),
      ),
      obscureText: !passwordVisible,
      controller: _passwordController,
    );
  }
}
