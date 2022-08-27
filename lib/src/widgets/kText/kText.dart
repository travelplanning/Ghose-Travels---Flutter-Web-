// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghose_travels/src/configs/appColors.dart';

class KText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;

  final String? fontFamily;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? wordSpacing;
  final double? letterSpacing;

  final TextDirection? textDirection;
  final TextDecoration? decoration;
  TextOverflow? overflow;

  KText({
    required this.text,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.maxLines,
    this.fontWeight,
    this.textAlign,
    this.textDirection,
    this.wordSpacing,
    this.letterSpacing,
    this.decoration,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: TextStyle(
        decoration: decoration,
        fontSize: fontSize != null ? fontSize : 16,
        // fontFamily: _langC.selectedLang.value == Locale('en', 'US')
        //     ? rubikRegular
        //     : bengaliRegular,
        // fontFamily: fontFamily != null ? fontFamily : rubikRegular,
        fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
        color: color != null ? color : black,
        wordSpacing: wordSpacing,
        overflow: overflow,
        letterSpacing: letterSpacing,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}
