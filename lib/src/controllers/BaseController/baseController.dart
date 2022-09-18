import 'package:get/get.dart';
import 'package:ghose_travels/src/controllers/bookings/bookings_controller.dart';
import 'package:ghose_travels/src/controllers/brands/brandsController.dart';
import 'package:ghose_travels/src/controllers/dashboard/dashboardController.dart';
import 'package:ghose_travels/src/controllers/fileUpload/firebaseImageUpload.dart';
import 'package:ghose_travels/src/controllers/slider/sliderController.dart';
import 'package:ghose_travels/src/controllers/users/users_controller.dart';
import 'package:ghose_travels/src/controllers/vehicles/vehiclesController.dart';

class BaseController {
  final sliderC = Get.put(SliderController());
  final vehiclesC = Get.put(VehiclesController());
  final usersController = Get.put(UsersController());
  final bookingsController = Get.put(BookingsController());
  final brandsC = Get.put(BrandsController());
  final dashboardC = Get.put(DashboardController());
  final fileUploadFirebaseC = Get.put(FirebaseFileUploadController());
}
