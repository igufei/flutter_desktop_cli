import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_cli/widgets/click.dart';

class Picker extends StatefulWidget {
  final String title;
  final PickerType type;
  String path;
  List<String>? allowedExtensions;
  final Function(String path) onFinished;
  Picker({
    super.key,
    required this.title,
    required this.onFinished,
    required this.type,
    this.path = '',
    this.allowedExtensions,
  });

  @override
  State<Picker> createState() => _PickerState();
}

enum PickerType { file, folder }

class _PickerState extends State<Picker> {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.black45;
    return Container(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      height: 27,
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: color, width: 1),
                      ),
                      child: Text(
                        locale: const Locale('zh', 'CN'),
                        widget.path,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                    child: Click(
                      onClick: () async {
                        if (widget.type == PickerType.folder) {
                          var dirPath = await getDirectoryPath();
                          setState(() {
                            widget.path = dirPath ?? '';
                          });
                          widget.onFinished(widget.path);
                        } else if (widget.type == PickerType.file) {
                          var file = await openFile(
                              acceptedTypeGroups: [XTypeGroup(label: '文件', extensions: widget.allowedExtensions)]);
                          setState(() {
                            widget.path = file?.path ?? '';
                          });
                          widget.onFinished(widget.path);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: color,
                        width: 27,
                        height: 27,
                        child: const Text(
                          '...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
