import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  const Input({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    Color color = Colors.black54;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(
            height: 27,
            child: TextField(
              controller: controller,
              cursorHeight: 18,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: false,
                prefixIcon: Container(
                  padding: const EdgeInsets.only(left: 5, right: 4),
                  //color: Colors.red,
                  child: Icon(
                    Icons.search,
                    size: 17,
                    color: color,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(minHeight: 17, minWidth: 17),
                hintText: hintText,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.zero,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.zero,
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.zero,
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.zero,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.zero,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.zero,
                ),
              ),
              style: const TextStyle(fontSize: 13, color: Colors.black),
              cursorColor: color,
              cursorWidth: 1,
            ),
          ),
        ],
      ),
    );
  }
}
