import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final String title;
  final double titleWidth;
  final Color titleColor;
  final String text;
  final String placeholder;
  final Function(String) onChanged;
  final TextInputType textInputType;
  const MyInput({
    Key? key,
    required this.title,
    required this.text,
    required this.placeholder,
    this.titleWidth = 0,
    required this.onChanged,
    this.textInputType = TextInputType.text,
    this.titleColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          titleWidth == 0
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    locale: Locale('zh', 'CN'),
                    title,
                    style: TextStyle(color: titleColor),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: titleWidth,
                    child: Text(
                      locale: Locale('zh', 'CN'),
                      title,
                      style: TextStyle(color: titleColor),
                    ),
                  ),
                ),
          Expanded(
            child: CupertinoTextField(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xff2c2c41),
                    width: 1,
                  )),
              cursorColor: Color(0xff2c2c41),
              placeholder: placeholder,
              placeholderStyle: TextStyle(fontSize: 12, color: Colors.black54),
              onChanged: onChanged,
              padding: EdgeInsets.only(left: 5, right: 5, top: 2.5, bottom: 2.5),
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: text,
                  selection: TextSelection.fromPosition(
                    TextPosition(
                      affinity: TextAffinity.upstream,
                      offset: text.length,
                    ),
                  ),
                ),
              ),
              cursorWidth: 1,
              cursorHeight: 15,
              keyboardType: textInputType,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
