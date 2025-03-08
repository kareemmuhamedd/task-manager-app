import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_tasks_app/app/di/init_dependencies.dart';
import 'package:management_tasks_app/features/auth/domain/entities/profile_entity.dart';
import 'package:management_tasks_app/features/auth/presentation/cubit/auth_cubit.dart';

import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        loginUseCase: serviceLocator<LoginUseCase>(),
        getCurrentUserUseCase: serviceLocator<GetCurrentUserUseCase>(),
      ),
      child: const UserProfileView(),
    );
  }
}

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getCurrentUser(); // Fetch user data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state.status == LogInSubmissionStatus.loading) {
            return const Center(
                child: CircularProgressIndicator()); // Show Loading
          } else if (state.status == LogInSubmissionStatus.error) {
            return Center(
                child: Text(state.message,
                    style: const TextStyle(color: Colors.red)));
          } else if (state.profile != null) {
            return _buildProfileUI(state.profile!);
          } else {
            return const Center(child: Text("No User Data Available"));
          }
        },
      ),
    );
  }

  Widget _buildProfileUI(ProfileEntity user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(radius: 50, backgroundImage: NetworkImage(user.image)),
          const SizedBox(height: 12),
          Text("${user.firstName} ${user.lastName}",
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text("@${user.username}", style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          _buildInfoCard(Icons.email, "Email", user.email),
          _buildInfoCard(Icons.phone, "Phone", user.phone),
          _buildInfoCard(Icons.cake, "Birthdate",
              "${user.birthDate.toLocal().toString().split(' ')[0]} (Age: ${user.age})"),
          _buildInfoCard(Icons.location_city, "Location",
              "${user.address.city}, ${user.address.country}"),
          _buildInfoCard(Icons.business, "Company",
              "${user.company.name} - ${user.company.title}"),
          _buildInfoCard(Icons.credit_card, "Bank Card",
              "${user.bank.cardType} - **** ${user.bank.cardNumber.substring(user.bank.cardNumber.length - 4)}"),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(color: Colors.black87)),
      ),
    );
  }
}
