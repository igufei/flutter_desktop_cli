import 'package:flutter/material.dart';

import 'desktop_route.dart';
import 'desktop_title_bar.dart';

class DesktopPage extends StatelessWidget {
  final String title;
  final Widget body;
  final RouteController routeController;
  const DesktopPage({
    super.key,
    required this.title,
    required this.body,
    required this.routeController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesktopTitleBar(
        title: title,
        routeController: routeController,
      ),
      body: DesktopRoute(
        controller: routeController,
        initWidget: body,
      ),
    );
  }
}
