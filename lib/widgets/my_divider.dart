import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  final Color color;
  const MyDivider({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      child: Container(color: color),
    );
  }
}
