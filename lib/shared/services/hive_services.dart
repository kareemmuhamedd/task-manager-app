// hive_service.dart
import 'package:hive_ce/hive.dart';
import 'package:management_tasks_app/shared/local_database/hive_registrar.g.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapters(); // From generated registrar
  }

  Future<Box<T>> openBox<T>(String boxName) async {
    return Hive.openBox<T>(boxName);
  }
}