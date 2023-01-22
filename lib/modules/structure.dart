import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

class Structure {
  static final _paths = [
    p.join(Directory.current.path, 'lib/modules'),
    p.join(Directory.current.path, 'lib/assets/fonts'),
    p.join(Directory.current.path, 'lib/assets/images'),
    p.join(Directory.current.path, 'lib/widgets'),
    p.join(Directory.current.path, 'lib/pages'),
    p.join(Directory.current.path, 'lib/routes'),
    p.join(Directory.current.path, 'lib/data'),
    p.join(Directory.current.path, 'lib/models'),
  ];
  static Future<void> create() async {
    await Directory(p.join(Directory.current.path, 'lib')).delete(recursive: true);
    await Directory(p.join(Directory.current.path, 'android')).delete(recursive: true);
    await Directory(p.join(Directory.current.path, 'ios')).delete(recursive: true);
    await Directory(p.join(Directory.current.path, 'web')).delete(recursive: true);
    await Directory(p.join(Directory.current.path, 'test')).delete(recursive: true);
    // 解压lib文件夹
    var buffer = await rootBundle.load('lib/assets/files/lib.zip');
    var inputStream = InputStream(buffer);
    var archive = ZipDecoder().decodeBuffer(inputStream);
    extractArchiveToDisk(archive, p.join(Directory.current.path, 'lib'));
    // 创建文件夹
    for (var path in _paths) {
      if (!Directory(path).existsSync()) {
        await Directory(path).create(recursive: true);
      }
    }
    var win32WindowFile = p.join(Directory.current.path, 'windows/runner/win32_window.cpp');
    //
    var content = await File(win32WindowFile).readAsString();
    content = content.replaceFirst('| WS_VISIBLE', '');
    await File(win32WindowFile).writeAsString(content);
  }
}
