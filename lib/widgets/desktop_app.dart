// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'click.dart';

class DesktopApp extends StatefulWidget {
  final String title;
  double width;
  double height;
  Color selectedColor;
  Color unselectedColor;
  final List<PageData> pages;
  int initIndex;
  Widget? leading;
  Widget? trailing;
  Function()? onInit;
  DesktopApp({
    super.key,
    required this.title,
    required this.pages,
    this.initIndex = 0,
    this.leading,
    this.trailing,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.black87,
    this.width = 1022,
    this.height = 670,
    this.onInit,
  });

  @override
  State<DesktopApp> createState() => _DesktopAppState();
}

class PageData {
  final String title;
  final IconData icon;
  final Widget Function() page;

  PageData({
    required this.title,
    required this.icon,
    required this.page,
  });
}

class _DesktopAppState extends State<DesktopApp> {
  var hoverIndex = -1;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          children: [
            Container(
              decoration:
                  const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 207, 206, 206)))),
              child: Column(children: [
                if (widget.leading != null) widget.leading!,
                const SizedBox(height: 10),
                ...widget.pages.asMap().entries.map((e) {
                  var btnBgColor = Colors.transparent;
                  var color = widget.unselectedColor;
                  if (widget.initIndex == e.key) {
                    color = widget.selectedColor;
                  }
                  if (hoverIndex == e.key) {
                    btnBgColor = const Color.fromARGB(15, 0, 0, 0);
                  } else {
                    btnBgColor = Colors.transparent;
                  }
                  return Click(
                    onClick: () {
                      setState(() {
                        widget.initIndex = e.key;
                      });
                    },
                    onHover: () {
                      setState(() {
                        hoverIndex = e.key;
                      });
                    },
                    onExit: () {
                      setState(() {
                        hoverIndex = -1;
                      });
                    },
                    child: Container(
                      width: 70,
                      color: btnBgColor,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Icon(
                            e.value.icon,
                            color: color,
                            size: 25,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            e.value.title,
                            style: TextStyle(
                              color: color,
                            ),
                            locale: const Locale('zh', 'CN'),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                const Spacer(),
                if (widget.trailing != null) widget.trailing!,
              ]),
            ),
            Expanded(
                child: IndexedStack(
              index: widget.initIndex,
              children: widget.pages.map((e) {
                return e.page.call();
              }).toList(),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> init() async {
    windowManager.waitUntilReadyToShow(
        WindowOptions(
          title: widget.title,
          size: Size(widget.width, widget.height),
          center: true,
          backgroundColor: Colors.transparent,
          skipTaskbar: false,
          titleBarStyle: TitleBarStyle.hidden,
        ), () async {
      await windowManager.setResizable(false);
      await windowManager.show();
      await windowManager.focus();
    });
  }

  @override
  void initState() {
    init();
    widget.onInit?.call();
    super.initState();
  }
}
