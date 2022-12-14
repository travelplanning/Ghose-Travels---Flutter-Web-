import 'package:flutter/material.dart';
import 'package:ghose_travels/src/configs/appColors.dart';

Widget addFileButton(
  context, {
  required void Function()? onTap,
  double? height,
  double? width,
  Widget? icon,
}) {
  var size = MediaQuery.of(context).size;
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? 200,
      width: width ?? size.width,
      decoration: BoxDecoration(
        border: Border.all(color: grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: icon ??
          Icon(
            Icons.add_a_photo_outlined,
            size: 40,
            color: grey,
          ),
    ),
  );
}
