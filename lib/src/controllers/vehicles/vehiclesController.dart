import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/models/vehicles/vehiclesModel.dart';

class VehiclesController extends GetxController {

  final _firestore = FirebaseFirestore.instance;

  Future<List<VehiclesModel>> getAllVehicles() async {
  List<VehiclesModel> vehicleList = [];

    try {
      await _firestore
          .collection('vehicles')
          .orderBy('time', descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          var model = VehiclesModel.fromDocumentSnapshot(element);
          vehicleList.clear();
          vehicleList.add(model);
        });
        return value;
      });
      return vehicleList;
    } catch (e) {
      print(e);
      rethrow;
    }
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
