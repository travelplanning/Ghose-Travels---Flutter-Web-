import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/widgets/snackbar/snackbar.dart';

class VehiclesController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

  final carNameTextC = TextEditingController();
  final brandNameTextC = TextEditingController();
  final carRentTextC = TextEditingController();
  final modelYearTextC = TextEditingController();

  //<-- for brandsOff -->
  final brandOfId = TextEditingController();
  final brandOfName = TextEditingController();

  final advancedPayAmountTextC = TextEditingController();

  var isAddVehicles = RxBool(false);
  var isUpdateVehicles = RxBool(false);
//brand Id
  var brandId = RxString('');

  clear() async {
    var _ = BaseController();
    carNameTextC.clear();
    brandNameTextC.clear();
    carRentTextC.clear();
    modelYearTextC.clear();
    brandOfId.clear();
    brandOfName.clear();
    _.fileUploadFirebaseC.selectedImage.value = '';
    advancedPayAmountTextC.clear();
  }

  addNewVehicles(String? image) async {
    String id = _firestore.collection("vehicles").doc().id.toString();
    try {
      await _firestore.collection('vehicles').doc(id).set({
        'carName': carNameTextC.text,
        'carRent': carRentTextC.text,
        'modelYear': modelYearTextC.text,
        'advancedPaymentAmount': advancedPayAmountTextC.text,
        'brandId': brandId.value,
        'brandName': brandNameTextC.text,
        'carId': id,
        'carImage': image,
        'search': setSearchParamForforVehicles(carNameTextC.text),
        'brandsOfName': brandOfName.text,
        'brandsOfId': brandOfId.text,
        'time': Timestamp.now(),
      });

      if (image!.isNotEmpty &&
          carRentTextC.text.isNotEmpty &&
          modelYearTextC.text.isNotEmpty &&
          advancedPayAmountTextC.text.isNotEmpty) {
        Get.back();
        isUpdateVehicles.value = false;
        isAddVehicles.value = false;
        snackBarWidget(message: 'Car Added!', isRed: false);

        clear();
      }
    } catch (e) {
      print(e);
    }
  }

  updateVehicles(id, String? image) async {
    try {
      await _firestore.collection('vehicles').doc(id).update({
        'carName': carNameTextC.text,
        'carRent': carRentTextC.text,
        'modelYear': modelYearTextC.text,
        'advancedPaymentAmount': advancedPayAmountTextC.text,
        'carImage': image,
        'brandId': brandId.value,
        'carId': id,
        'brandsOfName': brandOfName.text,
        'brandsOfId': brandOfId.text,
        'search': setSearchParamForforVehicles(carNameTextC.text),
      });

      if (image!.isNotEmpty &&
          carRentTextC.text.isNotEmpty &&
          modelYearTextC.text.isNotEmpty &&
          advancedPayAmountTextC.text.isNotEmpty) {
        Get.back();
        isUpdateVehicles.value = false;
        isAddVehicles.value = false;
        clear();

        snackBarWidget(message: 'Car Updated!', isRed: false);
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

  Stream<QuerySnapshot<Map<String, dynamic>>> searchVehicles(key) {
    return _firestore
        .collection('product')
        .where('search', arrayContains: key.toLowerCase())
        .orderBy('time', descending: true)
        .snapshots();
  }

  void removeVehicles(String id) async {
    try {
      await _firestore.collection('vehicles').doc(id).delete();
      if (id != '') {
        snackBarWidget(message: 'Car removed!', isRed: false);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  setSearchParamForforVehicles(String name) {
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < name.length; i++) {
      temp = temp + name[i].toLowerCase();
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }
}
