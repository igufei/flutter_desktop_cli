import 'package:flutter/widgets.dart';

class Visible extends StatelessWidget {
  final bool isVisible;
  final Widget child;
  const Visible({
    Key? key,
    required this.isVisible,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? child
        : const SizedBox(
            width: 0,
            height: 0,
          );
  }
}
