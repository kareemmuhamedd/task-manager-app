import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_tasks_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:management_tasks_app/features/auth/presentation/widgets/password_form_field.dart';
import 'package:management_tasks_app/features/auth/presentation/widgets/name_form_field.dart';

import '../../../../../shared/typography/app_text_styles.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Login',
            style: AppTextStyles.font24WeightBold,
          ),
          SizedBox(height: 24.h),
          const PhoneFormField(),
          const SizedBox(
            height: 20,
          ),
          const PasswordFormField(),
        ],
      ),
    );
  }
}
