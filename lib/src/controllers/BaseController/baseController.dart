import 'package:get/get.dart';
import 'package:ghose_travels/src/controllers/brands/brandsController.dart';
import 'package:ghose_travels/src/controllers/slider/sliderController.dart';
import 'package:ghose_travels/src/controllers/vehicles/vehiclesController.dart';

class BaseController {
  final sliderC = Get.put(SliderController());
  final vehiclesC = Get.put(VehiclesController());
  final brandsC = Get.put(BrandsController());
}
