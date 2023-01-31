import 'package:flutter/material.dart';
import 'package:flutter_desktop_cli/widgets/click.dart';

class MyRadioGroup extends StatefulWidget {
  final List<String> itemsText;
  late int selectIndex;
  late Color color;
  final Function(int) onChanged;

  MyRadioGroup({
    super.key,
    required this.itemsText,
    this.selectIndex = 0,
    this.color = Colors.black54,
    required this.onChanged,
  });

  @override
  State<MyRadioGroup> createState() => _MyRadioGroupState();
}

class _MyRadioGroupState extends State<MyRadioGroup> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widget.itemsText.asMap().entries.map((e) {
        int index = e.key;
        String value = e.value;
        return _radio(index, widget.selectIndex, value);
      }).toList(),
    );
  }

  Widget _radio(int currentIndex, int selectIndex, String text) {
    var radio = Icons.radio_button_off;
    if (currentIndex == selectIndex) {
      radio = Icons.radio_button_on;
    }
    return Click(
      onClick: () {
        setState(() {
          widget.selectIndex = currentIndex;
        });
        widget.onChanged(currentIndex);
      },
      child: Row(
        children: [
          Icon(radio, size: 18, color: widget.color),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              text,
              style: TextStyle(color: widget.color),
            ),
          )
        ],
      ),
    );
  }
}
