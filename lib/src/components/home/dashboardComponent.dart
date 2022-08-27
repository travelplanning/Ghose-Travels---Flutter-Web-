import 'package:flutter/material.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';
class DashboardComponent extends StatelessWidget {
 const DashboardComponent({Key? key}) : super(key: key);
@override
 Widget build(BuildContext context) {
return Scaffold(
body: ListView(
    children: [

      KText(text: 'text',color: redAccent,)
    ],
 ),);
 }
}