import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/configs/appTheme.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/pages/auth/loginPage.dart';
import 'package:ghose_travels/src/pages/bookings/booking_details_screen.dart';
import 'package:ghose_travels/src/pages/bookings/bookings_screen.dart';
import 'package:ghose_travels/src/pages/error/errorPage.dart';
import 'package:ghose_travels/src/pages/sliders/sliderPage.dart';
import 'package:ghose_travels/src/pages/users/users_screen.dart';
import 'package:ghose_travels/src/pages/vehicles/vehiclesListPage.dart';

import 'pages/dashboard/dashboardPage.dart';

class App extends StatelessWidget with BaseController {
  @override
  Widget build(BuildContext context) {
    sliderC.getAllSlider();
    usersController.getAllUsers();
    bookingsController.getAllBookings();
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
        GetPage(name: '/users', page: () => UsersScreen()),
        GetPage(name: '/bookings', page: () => BookingsScreen()),
        GetPage(name: '/booking_details', page: () => BookingDetailsScreen()),
      ],
    );
  }
}
