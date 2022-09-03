import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';

class ChangeBookingStatusService with BaseController {
  updateBookingStatus({required String status}) async {
    try {
      await FirebaseFirestore.instance
          .collection("bookings")
          .doc(bookingsController.tempDocId.value)
          .update({
        "status": status,
      }).then((value) {
        log("status changed");
        bookingsController.getAllBookings();
        Get.snackbar("Status updated", "Order status changed to $status");
        Get.toNamed('/bookings');
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
