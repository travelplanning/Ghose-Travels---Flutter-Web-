import 'package:get/get.dart';
import 'package:ghose_travels/src/controllers/bookings/bookings_controller.dart';
import 'package:ghose_travels/src/controllers/slider/sliderController.dart';
import 'package:ghose_travels/src/controllers/users/users_controller.dart';
import 'package:ghose_travels/src/controllers/vehicles/vehiclesController.dart';

class BaseController {
  final sliderC = Get.put(SliderController());
  final vehiclesC = Get.put(VehiclesController());
  final usersController = Get.put(UsersController());
  final bookingsController = Get.put(BookingsController());
}
