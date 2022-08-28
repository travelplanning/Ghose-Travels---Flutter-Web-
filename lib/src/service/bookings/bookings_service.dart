import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class BookingsService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      getAllBookings() async {
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection("bookings").get();
      var data = snapshot.docs;
      return data;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
