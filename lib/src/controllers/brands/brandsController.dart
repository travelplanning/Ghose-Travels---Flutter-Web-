import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/widgets/snackbar/snackbar.dart';

class BrandsController extends GetxController {
  var isAddBrands = RxBool(false);

  var isAddBrandsOff = RxBool(false);
  var isFormEnable = RxBool(false);
  var isUpdateBrandsOff = RxBool(false);

  var isAUpdateBrands = RxBool(false);
  var isVehicleEmpty = RxBool(true);

  var brandId = RxString('');
  var brandName = RxString('');
  final brandOfId = RxString('');

  final brandNameTextC = TextEditingController();
  final brandImageTextC = TextEditingController();
  final brandOfTextC = TextEditingController();

  final _firestore = FirebaseFirestore.instance;
  clear() {
    brandImageTextC.clear();
    brandNameTextC.clear();
    brandOfTextC.clear();

    brandId.value = '';
    brandOfId.value = '';
    brandName.value = '';

    isAUpdateBrands.value = false;
    isUpdateBrandsOff.value = false;
    isAddBrands.value = false;
    // isVehicleEmpty.value = true;
    isAddBrandsOff.value = false;
  }

  addNewBrand() async {
    String id = _firestore.collection("brands").doc().id.toString();

    try {
      await _firestore.collection('brands').doc(id).set({
        'id': id,
        'name': brandNameTextC.text,
        'image': brandImageTextC.text,
        'brandOf': brandOfTextC.text,
        'brandOfId': brandOfId.value,
        'time': Timestamp.now(),
      });

      if (id != '') {
        isAUpdateBrands.value = false;
        isAddBrands.value = false;

        snackBarWidget(
          message: 'Brand Added!!',
          isRed: false,
        );
        clear();
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  updateBrand(brandId) async {
    try {
      await _firestore.collection('brands').doc(brandId).update({
        'name': brandNameTextC.text,
        'image': brandImageTextC.text,
        'brandOf': brandOfTextC.text,
        'brandOfId': brandOfId.value,
      });

      if (brandId != '') {
        isAUpdateBrands.value = false;
        isAddBrands.value = false;
        snackBarWidget(
          message: 'Brand Updated!!',
          isRed: false,
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  addNewBrandsOf() async {
    String id = _firestore.collection("brandsOf").doc().id.toString();

    try {
      await _firestore.collection('brandsOf').add({
        'id': id,
        'brandsOfName': brandOfTextC.text,
        'time': Timestamp.now(),
      });
      if (id != '') {
        isFormEnable.value = false;
        snackBarWidget(
          message: 'Brands of added!!',
          isRed: false,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  updateBrandsOf() async {
    try {
      await _firestore.collection('brandsOf').doc(brandOfId.value).update({
        'brandsOfName': brandOfTextC.text,
      });

      if (brandOfId.value != '') {
        isFormEnable.value = false;

        isAddBrandsOff.value = false;
        snackBarWidget(
          message: 'Brand Of Updated!!',
          isRed: false,
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  removeBrandsOf(brandsOfId) async {
    try {
      await _firestore.collection('brandsOf').doc(brandsOfId).delete();

      if (brandsOfId != '') {
        snackBarWidget(
          message: 'Brands of removed!!',
          isRed: false,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllBrands() {
    return _firestore
        .collection('brands')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSingleBrand(brandId) {
    return _firestore
        .collection("brands")
        .where(
          "id",
          isEqualTo: brandId,
        )
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSingleBrandVehicles() {
    return _firestore
        .collection("vehicles")
        .where(
          "brandId",
          isEqualTo: brandId.value,
        )
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllBrandsOf() {
    return _firestore
        .collection('brandsOf')
        .orderBy('time', descending: true)
        .snapshots();
  }

  void removeBrands(String id) async {
    try {
      await _firestore.collection('brands').doc(id).delete();

      if (id != '') {
        snackBarWidget(
          message: 'Brand removed!!',
          isRed: false,
        );
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
