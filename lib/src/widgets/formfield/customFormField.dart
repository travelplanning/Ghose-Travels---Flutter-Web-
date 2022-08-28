import 'package:flutter/material.dart';
import 'package:ghose_travels/src/configs/appColors.dart';

Widget customFormField({
  String? hintText,
  double? hintTextSize,
  double? height,
  double? width,
  Color? textColor,
  Color? outlineColor,
  IconData? icons,
  Color? iconColor,
  double? iconSize,
  double? borderWidth,
  bool? isIconHide,
  Widget? suffixIcon,
  TextInputType? keyboardType,
  int? maxLines,
  int? minLines,
  bool? filled,
  Color? filledColor,
  bool? isOnlyNumber,
  void Function(String)? onChanged,
  void Function()? onTap,
  void Function(String)? onFieldSubmitted,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  TextStyle? textStyle,
  required TextEditingController controller,
  required BorderRadius borderRadius,
  bool readOnly = false,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: TextFormField(

      readOnly: readOnly ,
      controller: controller,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines,
      minLines: minLines,
      textAlign: textAlign == null ? TextAlign.start : textAlign,
      style: textStyle,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: outlineColor != null ? outlineColor : grey.shade300,
            width: borderWidth != null ? borderWidth : 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            // color: outlineColor != null ? outlineColor : buttonColorBlue,
            color: outlineColor == white ? white : black,
            width: borderWidth != null ? borderWidth : 1,
          ),
        ),
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 10, vertical: minLines == null ? 0 : 10),
        hintText: hintText,
        hintStyle: TextStyle(
          color: textColor == null ? black : textColor,
          fontSize: hintTextSize == null ? 14 : hintTextSize,
          fontWeight: fontWeight,
        ),
        fillColor: filledColor,
        filled: filled,
        prefixIcon: isIconHide == true
            ? null
            : Icon(
                icons != null ? icons : Icons.search,
                size: iconSize != null ? iconSize : 30,
                color: iconColor != null
                    ? iconColor
                    : buttonColorBlue.withOpacity(.5),
              ),
      ),
    ),
  );
}
