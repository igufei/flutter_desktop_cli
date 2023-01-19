import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final String title;
  final Widget child;
  const Box({Key? key, required this.title, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(2.0, 2.0), blurRadius: 4.0)],
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 6, bottom: 6),
            child: Text(title),
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(10),
            child: child,
          ),
        ],
      ),
    );
  }
}
