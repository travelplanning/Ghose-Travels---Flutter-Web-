import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:ghose_travels/src/widgets/snackbar/snackbar.dart';

class SliderController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  var sliderUrl = TextEditingController();
  addNewSlider({
    required sliderImage,
    required fileImage,
  }) async {
    try {
      String id = _firestore.collection("campaigns").doc().id.toString();
      await _firestore.collection("campaigns").doc(id).set({
        'campaignImage': sliderImage,
        'id': id,
        'time': Timestamp.now(),
      });

      if (sliderImage != null) {
        addSliderImage(fileImage);
        Get.back();
        snackBarWidget(message: 'Slider Added!', isRed: false);
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSlider() {
    return _firestore
        .collection('campaigns')
        .orderBy(
          'time',
          descending: true,
        )
        .snapshots();
  }

  void deleteSlider(String id) async {
    try {
      await _firestore.collection('campaigns').doc(id).delete();

      getAllSlider();
      if (id != '') {
        snackBarWidget(message: 'Slider removed!', isRed: false);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  addSliderImage(File image) async {
    File a = image;
    try {
      String nameImage = DateTime.now().millisecondsSinceEpoch.toString();

      var _reference =
          FirebaseStorage.instance.ref().child('images/$nameImage.png}');
      await _reference
          .putData(
        await a.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .whenComplete(() async {
        String id = _firestore.collection("campaigns").doc().id.toString();

        await _reference.getDownloadURL().then((value) {
          sliderUrl.text = value;
          print('____________________________>');
          print(value);
          print('____________________________>');

          _firestore.collection('campaigns').add({
            'campaignImage': value,
            'id': id,
            'time': Timestamp.now(),
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
