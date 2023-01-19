import 'package:flutter/material.dart';

class MyCheckBox extends StatelessWidget {
  final String title;
  final bool status;
  final Function(bool?)? onChanged;
  const MyCheckBox({Key? key, required this.title, required this.onChanged, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Checkbox(
            value: status,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            overlayColor: MaterialStateProperty.all(
              Colors.transparent,
            ),
            visualDensity: VisualDensity.compact,
          ),
          GestureDetector(
            onTap: () {
              onChanged?.call(!status);
            },
            child: Text(
              locale: Locale('zh', 'CN'),
              title,
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
