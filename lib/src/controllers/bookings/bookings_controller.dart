import 'package:get/get.dart';
import 'package:ghose_travels/src/service/bookings/bookings_service.dart';

class BookingsController extends GetxController {
  var  allBookings = <Map<String, dynamic>>[].obs;
  var pendingBookings = <Map<String, dynamic>>[].obs;
  var confirmedBookings = <Map<String, dynamic>>[].obs;
  var cancelledBookings = <Map<String, dynamic>>[].obs;
  var inTransitBookings = <Map<String, dynamic>>[].obs;

  var bookingsListDocIds =
      <String>[].obs; // for saving document id to get purchase details

  var selectedBookings = <Map<String, dynamic>>[].obs;
  var selectedCategory = "".obs;

  var tempDocId = "".obs;

  getAllBookings() async {
    var temp = await BookingsService().getAllBookings();

    allBookings.clear();
    pendingBookings.clear();
    confirmedBookings.clear();
    cancelledBookings.clear();
    inTransitBookings.clear();

    if (temp != null) {
      allBookings.clear();
      for (var i = 0; i < temp.length; i++) {
        allBookings.add(temp[i].data());
        bookingsListDocIds.add(temp[i].id);
      }
      showAllBookings();
    }

    if (allBookings.isNotEmpty) {
      for (var i = 0; i < allBookings.length; i++) {
        if (allBookings[i]['status'] == 'pending') {
          pendingBookings.add(allBookings[i]);
        }
      }
    }
    if (allBookings.isNotEmpty) {
      for (var i = 0; i < allBookings.length; i++) {
        if (allBookings[i]['status'] == 'cancelled') {
          cancelledBookings.add(allBookings[i]);
        }
      }
    }
    if (allBookings.isNotEmpty) {
      for (var i = 0; i < allBookings.length; i++) {
        if (allBookings[i]['status'] == 'confirmed') {
          confirmedBookings.add(allBookings[i]);
        }
      }
    }
    if (allBookings.isNotEmpty) {
      for (var i = 0; i < allBookings.length; i++) {
        if (allBookings[i]['status'] == 'inTransit') {
          inTransitBookings.add(allBookings[i]);
        }
      }
    }
  }

  showAllBookings() {
    if (allBookings.isNotEmpty) {
      selectedBookings.clear();
      selectedCategory.value = "all";
      selectedBookings.addAll(allBookings);
    }
  }

  showPendingBookings() {
    selectedBookings.clear();
    selectedCategory.value = "pending";
    selectedBookings.addAll(pendingBookings);
  }

  showCancelledBookings() {
    selectedBookings.clear();
    selectedCategory.value = "cancelled";
    selectedBookings.addAll(cancelledBookings);
  }

  showConfirmedBookings() {
    selectedBookings.clear();
    selectedCategory.value = "confirmed";
    selectedBookings.addAll(confirmedBookings);
  }

  showInTransitBookings() {
    selectedBookings.clear();
    selectedCategory.value = "in transit";
    selectedBookings.addAll(inTransitBookings);
  }

  getTempDocId(String temp) {
    tempDocId.value = temp;
    print(tempDocId.value);
  }
}
