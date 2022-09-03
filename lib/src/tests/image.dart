// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget imageShow(imageUrl) {
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
    imageUrl,
    (int _) => ImageElement(
      src: imageUrl,
      height: Get.height.toInt(),
      width: Get.width.toInt(),
    ),
  );
  return HtmlElementView(
    viewType: imageUrl,
  );
}
