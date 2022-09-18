import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/widgets/snackbar/snackbar.dart';
import 'package:image_picker/image_picker.dart';

class SliderController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

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

  addSliderImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      Uint8List? uploadFile = await image.readAsBytes();

      Reference reference = FirebaseStorage.instance.ref('sliders').child(image.name);

      SettableMetadata settableMetadata = SettableMetadata(customMetadata: {});

      final UploadTask uploadTask =
          reference.putData(uploadFile, settableMetadata);

      uploadTask.whenComplete(() async {
        var downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();

        if (downloadUrl != '') {
          String id = _firestore.collection("campaigns").doc().id.toString();
          await _firestore.collection("campaigns").doc(id).set({
            'campaignImage': downloadUrl,
            'id': id,
            'time': Timestamp.now(),
          });
          snackBarWidget(message: 'Slider Added!', isRed: false);
        }
      });
    }
  }
}
