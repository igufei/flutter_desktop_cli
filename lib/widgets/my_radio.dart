import 'package:flutter/material.dart';

class MyRadio<T> extends StatelessWidget {
  final String title;
  final T value;
  final T groupValue;
  final Function(T) onChanged;
  const MyRadio({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.value,
    required this.groupValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(
          value: value,
          onChanged: (val) {
            onChanged(val!);
          },
          activeColor: Colors.greenAccent[700],
          groupValue: groupValue,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        )
      ],
    );
  }
}
