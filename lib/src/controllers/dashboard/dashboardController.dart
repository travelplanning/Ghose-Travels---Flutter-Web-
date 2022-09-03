import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return _firestore.collection('users').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBookings() {
    return _firestore.collection('bookings').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCancelledBookings() {
    return _firestore
        .collection("bookings")
        .where("status", isEqualTo: "cancelled")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPendingBookings() {
    return _firestore
        .collection("bookings")
        .where("status", isEqualTo: "pending")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getConfirmedBookings() {
    return _firestore
        .collection("bookings")
        .where("status", isEqualTo: "confirmed")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTransitBookings() {
    return _firestore
        .collection("bookings")
        .where("status", isEqualTo: "inTransit")
        .snapshots();
  }
}
