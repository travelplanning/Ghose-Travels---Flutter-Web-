import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BrandsController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllBrands() {
    return _firestore
        .collection('brands')
        .orderBy('time', descending: true)
        .snapshots();
  }

  void removeBrands(String id) async {
    try {
      await _firestore.collection('brands').doc(id).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
