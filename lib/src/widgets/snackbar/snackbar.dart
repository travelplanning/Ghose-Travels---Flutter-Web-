import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../configs/appColors.dart';

snackBarWidget({
  String? title,
  required String? message,
  required bool? isRed,
  bool? isShowSnackbar,
  ToastGravity? gravity,
}) {
  return isShowSnackbar == null
      ? isRed == false
          ? Fluttertoast.showToast(
              msg: message.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: gravity != null ? gravity : ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2.5.toInt(),
              webBgColor: "linear-gradient(to right, #00b09b, #00b09b)",
              backgroundColor: green,
              webPosition: "right",
              webShowClose: true,
              textColor: white,
              fontSize: 14,
            )
          : Fluttertoast.showToast(
              webPosition: "right",
              
              webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
              timeInSecForIosWeb: 2.5.toInt(),
              msg: message.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: redAccent,
              textColor: white,
              fontSize: 14,
            )
      : Container();
}

emptySnackBarWidget() => snackBarWidget(
      message: '''Field can't be null!''',
      isRed: true,
      gravity: ToastGravity.CENTER,
    );
