import 'package:flutter/material.dart';

class FormItem extends StatelessWidget {
  final String title;
  final Widget child;
  const FormItem({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.normal)),
            Container(
              height: 27,
              padding: const EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45, width: 1),
              ),
              child: child,
            ),
          ],
        ));
    ;
  }
}
