// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';

class Click extends StatelessWidget {
  final Widget child;
  final Function() onClick;
  Function()? onHover;
  Function()? onExit;
  Function()? onTapDown;
  Click({
    super.key,
    required this.child,
    required this.onClick,
    this.onHover,
    this.onExit,
    this.onTapDown,
  });
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onExit: (event) {
        onExit?.call();
      },
      onHover: (event) {
        onHover?.call();
      },
      child: GestureDetector(
        onTap: onClick,
        onTapDown: (details) {
          onTapDown?.call();
        },
        child: child,
      ),
    );
  }
}
