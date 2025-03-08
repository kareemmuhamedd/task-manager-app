import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_tasks_app/app/di/init_dependencies.dart';
import 'package:management_tasks_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:management_tasks_app/shared/typography/app_text_styles.dart';
import '../../../../app/bloc/app_bloc.dart';
import '../../../../shared/assets/images.dart';
import '../../../../shared/utilities/snack_bars/custom_snack_bar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        loginUseCase: serviceLocator<LoginUseCase>(),
        getCurrentUserUseCase: serviceLocator<GetCurrentUserUseCase>(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AppImages.artImage),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoginForm(),
                  const SizedBox(
                    height: 24,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state.status == LogInSubmissionStatus.success) {
                        context
                            .read<AppBloc>()
                            .add(const DetermineAppStateRequested());
                      } else if (state.status == LogInSubmissionStatus.error) {
                        showCustomSnackBar(
                          context,
                          state.message,
                          isError: true,
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoading =
                          state.status == LogInSubmissionStatus.loading;
                      return AppButton(
                        isInProgress: isLoading,
                        onPressed: () {
                          context.read<AuthCubit>().onSubmitted();
                        },
                        appButtonWidget: const Text(
                          'Sign in',
                          style: AppTextStyles.font16WeightBold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
