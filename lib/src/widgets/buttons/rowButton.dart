import 'package:flutter/material.dart';
import 'package:ghose_travels/src/configs/apputils.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';

rowButton({
  required IconData icon,
  required String? text,
  required void Function()  onTap,
  bool? arrowOn,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: paddingH10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          sizeW30,
          KText(text: text,fontSize: 18,),
          Spacer(),
          
          arrowOn == true
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                )
              : Container(),
        ],
      ),
    ),
  );
}
