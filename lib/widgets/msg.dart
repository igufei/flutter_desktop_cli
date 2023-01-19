import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Msg {
  static confirm(String title, String text,
      {String okText = '确认', required Function()? onOK, required Function()? onCancel, barrierDismissible = true}) {
    Get.dialog(
        Dialog(
          //backgroundColor: const Color(0xffFAF3ED),
          elevation: 2,
          /* shape: Border.all(
            color: const Color(0xFFC5C2C1),
          ), */
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    locale: const Locale('zh', 'CN'),
                    title,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 15),
                  child: Text(
                    locale: const Locale('zh', 'CN'),
                    text,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: onCancel,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(onCancel == null ? "" : "取消"),
                        ),
                      ),
                      InkWell(
                        onTap: onOK,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(okText, style: TextStyle(color: Colors.green[800])),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        barrierDismissible: barrierDismissible);
  }

  static dialog({required String title, required Widget content}) {
    Get.dialog(
      Dialog(
        /* backgroundColor: const Color(0xFFF8F7F6),
        elevation: 5,
        shape: Border.all(
          color: const Color(0xFFC2BDBB),
        ), */
        child: Container(
          padding: const EdgeInsets.all(8.0),
          //decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale: const Locale('zh', 'CN'),
                        title,
                        style: const TextStyle(color: Color(0xFF111110), fontSize: 16),
                      ),
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Text(
                            locale: Locale('zh', 'CN'),
                            "×",
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          ))
                    ],
                  ),
                ),
                content
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
    return;
  }

  static snackbar(String text, {textColor = Colors.white}) {
    if (Get.isSnackbarOpen) {
      return;
    }
    Get.snackbar(
      '提示',
      text,
      margin: const EdgeInsets.only(top: 10),
      backgroundColor: textColor == Colors.white ? Colors.black54 : Colors.white,
      colorText: textColor,
      titleText: Container(),
      maxWidth: 300,
    );
  }
}
