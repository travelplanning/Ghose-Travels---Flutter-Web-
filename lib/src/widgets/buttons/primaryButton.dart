import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';


primaryButton({
  required buttonName,
  required void Function()? onTap,
}) =>
    ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          buttonColorBlue,
        ),
      ),
      child: SizedBox(
        height: 50,
        width: Get.width,
        child: Center(
          child: KText(
            text: buttonName,
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
