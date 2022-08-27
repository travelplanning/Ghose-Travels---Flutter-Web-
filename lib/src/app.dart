import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/configs/appTheme.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/pages/auth/loginPage.dart';
import 'package:ghose_travels/src/pages/error/errorPage.dart';
import 'package:ghose_travels/src/pages/sliders/sliderPage.dart';
import 'package:ghose_travels/src/pages/vehicles/vehiclesListPage.dart';

import 'pages/dashboard/dashboardPage.dart';

class App extends StatelessWidget with BaseController {
  @override
  Widget build(BuildContext context) {
    sliderC.getAllSlider();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.onlyBuilder,
      theme: AppTheme.appTheme,
      initialRoute: '/login',
      unknownRoute: GetPage(name: '/error', page: () => ErrorPage()),
      getPages: [
        // GetPage(name: '/', page: () => Root()),
        GetPage(name: '/dashboard', page: () => DashboardPage()),
        GetPage(name: '/error', page: () => ErrorPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/sliders', page: () => SliderPage()),
        GetPage(name: '/vehiclesList', page: () => VehiclesListPage()),
      ],
    );
  }
}
