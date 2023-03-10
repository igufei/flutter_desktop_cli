import 'package:flutter/material.dart';
import 'package:flutter_desktop_cli/pages/home/components/form_item.dart';
import 'package:flutter_desktop_cli/pages/home/components/input.dart';
import 'package:flutter_desktop_cli/pages/home/components/picker.dart';
import 'package:flutter_desktop_cli/widgets/click.dart';
import 'package:flutter_desktop_cli/widgets/my_radio_group.dart';
import 'package:flutter_desktop_cli/widgets/visible.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../widgets/desktop_page.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  final controller = Get.put(HomeController());
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DesktopPage(
      title: '主界面',
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(top: 30, left: 200, right: 200),
            children: [
              MyRadioGroup(
                  itemsText: ['移动端项目', '桌面端项目'],
                  color: Colors.blue,
                  selectIndex: controller.platform.value,
                  onChanged: (index) {
                    controller.platform.value = index;
                  }),
              SizedBox(height: 10),
              Input(title: '项目名称', hintText: '项目名称只能使用字母、数字、下划线组成', controller: controller.projectNameC),
              Input(title: '公司组织', hintText: 'com.example', controller: controller.companyNameC),
              Obx(() => Visible(
                    isVisible: controller.platform.value == 0,
                    child: FormItem(
                      title: 'IOS端语言',
                      child: MyRadioGroup(
                          itemsText: ['Swift', 'Objective-C'],
                          selectIndex: controller.iosLanguage.value,
                          onChanged: (index) {
                            controller.iosLanguage.value = index;
                          }),
                    ),
                  )),
              Obx(() => Visible(
                    isVisible: controller.platform.value == 0,
                    child: FormItem(
                      title: 'Android端语言',
                      child: MyRadioGroup(
                          itemsText: ['Kotlin', 'Java'],
                          selectIndex: controller.androidLanguage.value,
                          onChanged: (index) {
                            controller.androidLanguage.value = index;
                          }),
                    ),
                  )),
              /* Picker(
                title: '软件图标',
                onFinished: (path) {
                  controller.projectIconPath = path;
                },
                type: PickerType.file,
                allowedExtensions: const ['ico'],
              ), */
              Picker(
                title: '项目路径',
                type: PickerType.folder,
                onFinished: (path) {
                  controller.projectPath = path;
                },
              ),
              GFButton(
                onPressed: () {
                  controller.generateDesktopProject(context);
                },
                text: '创建项目',
                size: 30,
                shape: GFButtonShape.square,
                fullWidthButton: true,
              ),
              Obx(() => Text(controller.log.value))
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topRight,
            child: Click(
                child: const Icon(Icons.settings),
                onClick: () {
                  controller.setFlutterPath(context);
                }),
          ),
        ],
      ),
      routeController: controller.rc,
    );
  }
}
