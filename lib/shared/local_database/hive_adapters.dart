import 'package:hive_ce/hive.dart';
import 'package:management_tasks_app/features/todos/data/models/todo_details_model.dart';
import 'package:management_tasks_app/features/todos/data/models/todo_model.dart';
import '../../features/auth/data/models/profile_model.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<ProfileModel>(),
  AdapterSpec<HairModel>(),
  AdapterSpec<AddressModel>(),
  AdapterSpec<BankModel>(),
  AdapterSpec<CompanyModel>(),
  AdapterSpec<CryptoModel>(),
  AdapterSpec<CoordinatesModel>(),
  AdapterSpec<TodoModel>(),
  AdapterSpec<TodoDetailsModel>(),
])
// ignore: unused_element
void _() {}
