import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class VehiclesController extends GetxController {

  final _firestore = FirebaseFirestore.instance;


  
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllVehicles() {
    return _firestore.collection('vehicles')
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
