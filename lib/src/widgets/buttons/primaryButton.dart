import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';


Widget primaryButton({
  required buttonName,
  required void Function()? onTap,
  double? height,
  double? width,
  IconData? icons,
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
      child: icons!=null?Row(children: [

        Icon(icons),
        SizedBox(
                  height: height == null ? 50 : height,
                  width: width == null ? Get.width : width,
                  child: Center(
                    child: KText(
                      text: buttonName,
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
      ],) : SizedBox(
        height:height==null? 50:height,
        width:width==null?  Get.width:width,
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
