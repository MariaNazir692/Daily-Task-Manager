import 'package:daily_task_manager/helper/db_helper.dart';
import 'package:daily_task_manager/services/theme_services/theme_services.dart';
import 'package:daily_task_manager/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:daily_task_manager/utils/theme/app_theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.dbInit();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Task Manager',
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      themeMode: themeServices().theme,
      home: const HomeScreen(),
    );
  }
}

