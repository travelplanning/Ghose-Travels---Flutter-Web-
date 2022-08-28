
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/configs/apputils.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';

dividerWithText({required title}) {
  return Row(
    children: [
      KText(text: title),
      sizeW20,
      Expanded(
        child: Container(
          color: grey,
          height: 1,
        ),
      ),
    ],
  );
}

divider() {
  return Container(
    color: grey,
    height: 1,
    width: Get.width,
  );
}
