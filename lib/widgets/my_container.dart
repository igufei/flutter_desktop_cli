import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final int styleType;
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double width;
  const MyContainer({
    Key? key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    required this.width,
    this.styleType = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var newpadding = padding;
    if (padding == EdgeInsets.zero) {
      newpadding = EdgeInsets.all(5);
    }
    if (styleType == 0) {
      return Container(
        width: width,
        margin: margin,
        padding: newpadding,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(2, 2),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
            /* border: Border.all(
              color: Color.fromARGB(255, 150, 149, 149),
              width: 0.5,
            ), */
            color: Color.fromARGB(255, 133, 189, 164)),
        child: child,
      );
    } else {
      return Container(
        width: width,
        margin: margin,
        padding: newpadding,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xfffe520a),
              width: 0.5,
            ),
            color: Color(0xfffaf3ed)),
        child: child,
      );
    }
  }
}
