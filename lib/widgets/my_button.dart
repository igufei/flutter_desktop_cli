import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final Function() onPressed;
  const MyButton({
    Key? key,
    required this.title,
    this.isExpanded = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: isExpanded ? double.infinity : null,
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Get.theme.primaryColor),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
          padding: MaterialStateProperty.all(EdgeInsets.all(2)),
        ),
        onPressed: onPressed,
        child: Text(
          locale: Locale('zh', 'CN'),
          title,
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}
