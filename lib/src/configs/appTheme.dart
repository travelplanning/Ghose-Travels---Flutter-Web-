import 'package:flutter/material.dart';
import 'package:ghose_travels/src/configs/appColors.dart';

class AppTheme {
  static final appTheme = ThemeData(
    scaffoldBackgroundColor: white,
    appBarTheme: AppBarTheme(
      elevation: .8,
      iconTheme: IconThemeData(
        color: black,
        size: 25,
      ),
      backgroundColor: green,
    ),
  );
}
