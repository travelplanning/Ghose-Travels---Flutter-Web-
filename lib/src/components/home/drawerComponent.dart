// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/configs/appUtils.dart';
import 'package:ghose_travels/src/helpers/dividerWithText.dart';
import 'package:ghose_travels/src/widgets/buttons/rowButton.dart';
import 'package:ghose_travels/src/widgets/card/customCardWidget.dart';

class DrawerComponent {
  @override
  Widget build(BuildContext context) {
    return customDrawer(context);
  }

  customDrawer(context, {double? width}) {
    var size = MediaQuery.of(context).size;

    return CustomCardWidget(
      elevation: 10,
      color: white,
      child: Container(
        height: size.height,
        width: width ?? size.width / 5,
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: [
            FlutterLogo(
              size: 150,
            ),
            sizeH10,
            divider(),
            sizeH10,
            rowButton(
              onTap: () => Get.toNamed('/dashboard'),
              icon: Icons.dashboard_outlined,
              text: 'Dashboard',
            ),
            sizeH20,
            rowButton(
              onTap: () => Get.offNamed('/brands'),
              icon: Icons.list_alt_outlined,
              text: 'Brands',
              arrowOn: true,
            ),
            sizeH20,
            rowButton(
              onTap: () => Get.toNamed('/vehiclesList'),
              icon: Icons.local_taxi_outlined,
              text: 'Vehicles',
              arrowOn: true,
            ),
            sizeH20,
            rowButton(
              onTap: () {},
              icon: Icons.bookmark_outline,
              text: 'Bookings',
            ),
            // sizeH20,
            // rowButton(
            //   onTap: () {},
            //   icon: Icons.campaign_outlined,
            //   text: 'Campaigns',
            // ),
            sizeH20,
            rowButton(
              onTap: () => Get.offNamed('/sliders'),
              icon: Icons.photo_library_outlined,
              text: 'Sliders',
            ),
            sizeH20,
            rowButton(
              onTap: () {},
              icon: Icons.person_outline,
              text: 'Users',
            ),
            sizeH20,
            rowButton(
              onTap: () {},
              icon: Icons.settings_outlined,
              text: 'Settings',
              arrowOn: true,
            ),
            sizeH20,
            rowButton(
              onTap: () => Get.offAllNamed('/login'),
              icon: Icons.logout_outlined,
              text: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
