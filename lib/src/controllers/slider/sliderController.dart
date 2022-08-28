import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

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
        Get.back();

        Get.snackbar('Success!', 'Slider Added');
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSlider() {
    return _firestore.collection('campaigns').orderBy('time',descending: true,).snapshots();
  }

  void deleteSlider(String id) async {
    try {
      await _firestore.collection('campaigns').doc(id).delete();

      getAllSlider();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
