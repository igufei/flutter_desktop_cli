import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../modules/flutter.dart';
import '../../modules/structure.dart';
import '../../widgets/desktop_route.dart';

class HomeController extends GetxController {
  RouteController rc = RouteController();
  TextEditingController projectNameC = TextEditingController();
  TextEditingController companyNameC = TextEditingController();
  var projectPath = '';
  var projectIconPath = '';
  var log = ''.obs;
  var isTask = false;
  void generateDesktopProject(BuildContext context) async {
    if (isTask) {
      GFToast.showToast(
        '项目正在构建中，请稍后尝试。',
        context,
        toastPosition: GFToastPosition.BOTTOM,
        toastDuration: 3,
      );
      return;
    }
    if (projectNameC.text.trim() == '') {
      //Msg.snackbar('项目名称不能为空');
      GFToast.showToast(
        '项目名称不能为空,项目名称只能使用字母、数字、下划线组成',
        context,
        toastPosition: GFToastPosition.BOTTOM,
        toastDuration: 3,
      );
      return;
    }
    if (companyNameC.text.trim() == '') {
      GFToast.showToast(
        '公司名称不能为空,命名方式为com.example',
        context,
        toastPosition: GFToastPosition.BOTTOM,
        toastDuration: 3,
      );
      return;
    }
    if (projectPath == '') {
      GFToast.showToast(
        '项目存储路径不能为空',
        context,
        toastPosition: GFToastPosition.BOTTOM,
        toastDuration: 3,
      );
      return;
    }
    /* if (projectIconPath == '') {
      GFToast.showToast(
        '软件图片路径不能为空',
        context,
        toastPosition: GFToastPosition.BOTTOM,
        toastDuration: 3,
      );
      return;
    } */
    isTask = true;
    log.value = '';
    var time = Stopwatch();
    time.start();
    var path = '$projectPath\\${projectNameC.text.trim()}';
    printLog('开始构建项目...');
    await Flutter.create(path, companyNameC.text.trim(), 'swift', 'java');
    printLog('开始生成项目结构...');
    await Structure.create();
    printLog('开始添加依赖插件...');
    await Flutter.pubAdd('get');
    await Flutter.pubAdd('window_manager');
    await Flutter.pubAdd('get_storage');
    await Flutter.pubAdd('package_info_plus');
    await Flutter.pubGet();
    printLog('项目构建成功');
    Directory.current = './';
    isTask = false;
    time.stop();
    print(time.elapsed.inMicroseconds);
  }

  void printLog(String text) {
    log.value += '$text\n';
  }
}
