import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'app/di/init_dependencies.dart';
import 'app/view/app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const App(),
    ),
  );
}
