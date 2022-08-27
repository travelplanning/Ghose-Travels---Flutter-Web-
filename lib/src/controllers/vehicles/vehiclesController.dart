import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VehiclesController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

  final carNameTextC = TextEditingController();
  final brandNameTextC = TextEditingController();
  final carRentTextC = TextEditingController();
  final modelYearTextC = TextEditingController();
  final carImageTextC = TextEditingController();
  final advancedPayAmountTextC = TextEditingController();

  addNewVehicles({required brandId}) async {
    String id = _firestore.collection("vehicles").doc().id.toString();
    try {
      await _firestore.collection('vehicles').doc(id).set({
        'carName': carNameTextC.text,
        'carRent': carRentTextC.text,
        'modelYear': modelYearTextC.text,
        'advancedPaymentAmount': advancedPayAmountTextC.text,
        'carImage': carImageTextC.text,
        'brandId': brandId,
        'carId': id,
        'time': Timestamp.now(),
      });

      if (carImageTextC.text.isNotEmpty &&
          carRentTextC.text.isNotEmpty &&
          modelYearTextC.text.isNotEmpty &&
          carImageTextC.text.isNotEmpty &&
          advancedPayAmountTextC.text.isNotEmpty) {
        Get.back();

        Get.snackbar('Success!', 'Car Added!');
        carImageTextC.clear();
        carRentTextC.clear();
        modelYearTextC.clear();
        carImageTextC.clear();
        advancedPayAmountTextC.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllVehicles() {
    return _firestore
        .collection('vehicles')
        .orderBy('time', descending: true)
        .snapshots();
  }

  void removeVehicles(String id) async {
    try {
      await _firestore.collection('vehicles').doc(id).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
