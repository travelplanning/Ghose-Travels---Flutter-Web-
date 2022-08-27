import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:ghose_travels/src/models/sliders/sliderModel.dart';

class SliderController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  var sliderUrl = TextEditingController();
  addNewSlider({
    required sliderImage,
  }) async {
    try {
      String id = _firestore.collection("campaigns").doc().id.toString();
      await _firestore.collection("campaigns").doc(id).set({
        'campaignImage': sliderImage,
        'id': id,
        'time': Timestamp.now(),
      });

      if (sliderImage != null) {
        getAllSlider();
        Get.snackbar('Success!', 'Slider Added');

        Get.back();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<SliderModel>> getAllSlider() async {
    List<SliderModel> sliderList = [];

    try {
      await _firestore
          .collection('campaigns')
          .orderBy('time', descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          var model = SliderModel.fromDocumentSnapshot(element);
          sliderList.clear();
          sliderList.add(model);
        });
        return value;
      });
      return sliderList;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void deleteSlider(String id) async {
    try {
      await _firestore.collection('campaigns').doc(id).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
