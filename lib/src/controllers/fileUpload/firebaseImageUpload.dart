import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseFileUploadController extends GetxController {
  var selectedImage = RxString('');

  pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      Uint8List? uploadFile = await image.readAsBytes();

      Reference reference = FirebaseStorage.instance.ref().child(image.name);

      SettableMetadata settableMetadata = SettableMetadata(customMetadata: {});

      final UploadTask uploadTask =
          reference.putData(uploadFile, settableMetadata);

      uploadTask.whenComplete(() async {
        var downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();

        selectedImage.value = downloadUrl;
      });
    }
  }
}
