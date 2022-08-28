import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:ghose_travels/src/controllers/bookings/bookings_controller.dart';
=======
import 'package:ghose_travels/src/controllers/brands/brandsController.dart';
>>>>>>> e1819337018ad858d4accdc2dc7d0e343e3c1d03
import 'package:ghose_travels/src/controllers/slider/sliderController.dart';
import 'package:ghose_travels/src/controllers/users/users_controller.dart';
import 'package:ghose_travels/src/controllers/vehicles/vehiclesController.dart';

class BaseController {
  final sliderC = Get.put(SliderController());
  final vehiclesC = Get.put(VehiclesController());
<<<<<<< HEAD
  final usersController = Get.put(UsersController());
  final bookingsController = Get.put(BookingsController());
=======
  final brandsC = Get.put(BrandsController());
>>>>>>> e1819337018ad858d4accdc2dc7d0e343e3c1d03
}
