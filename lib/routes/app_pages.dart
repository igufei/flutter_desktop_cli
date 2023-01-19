import 'package:flutter/material.dart';

import '../pages/home/home_page.dart';
import '../widgets/desktop_app.dart';

class AppPages {
  static final routes = [
    PageData(title: '主面板', icon: Icons.home, page: () => HomePage()),
  ];
}
