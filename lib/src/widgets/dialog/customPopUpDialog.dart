import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/configs/appUtils.dart';

import '../../helpers/dividerWithText.dart';
import '../kText/kText.dart';

Future<void> customDialogWidget(
  context, {
  List<Widget>? actions,
  required Widget child,
  required String? headerTitle,
  double? height,
  double? width,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: KText(
          text: headerTitle,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: black,
        ),
        content: Container(
            height: height ?? Get.height / 2,
          width: width ?? Get.width,
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  divider(),
                  sizeH20,
                  child,
                ],
              ),
            ],
          ),
        ),
        actions: actions,
      );
    },
  );
}
