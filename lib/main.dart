import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:window_manager/window_manager.dart';

import 'routes/app_pages.dart';
import 'widgets/desktop_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await GetStorage.init();

  runApp(DesktopApp(
    title: '我的应用',
    pages: AppPages.routes,
    width: 800,
    height: 600,
  ));
}
