import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/components/home/drawerComponent.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/pages/bookings/widgets/bookings_list_tile.dart';
import 'package:ghose_travels/src/widgets/white_space/vertical_space.dart';

import 'widgets/bookings_info_container.dart';

class BookingsScreen extends StatelessWidget with BaseController {
  BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: Row(
        children: [
          Container(
            child: DrawerComponent().customDrawer(context),
          ),
          Expanded(
              child: Container(
            height: height * 100,
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: width * 70,
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpace(height: 20),
                    Obx(() {
                      return Row(
                        children: [
                          BookingsInfoContainer(
                              function: () {
                                bookingsController.showAllBookings();
                              },
                              number:
                                  "${bookingsController.allBookings.length}",
                              categoryName: "Total Bookings",
                              height: height,
                              width: width),
                          BookingsInfoContainer(
                              function: () {
                                bookingsController.showConfirmedBookings();
                              },
                              number:
                                  "${bookingsController.confirmedBookings.length}",
                              categoryName: "Confirmed",
                              height: height,
                              width: width),
                          BookingsInfoContainer(
                              function: () {
                                bookingsController.showPendingBookings();
                              },
                              number: bookingsController.pendingBookings.length
                                  .toString(),
                              categoryName: "Pending",
                              height: height,
                              width: width),
                          BookingsInfoContainer(
                              function: () {
                                bookingsController.showCancelledBookings();
                              },
                              number:
                                  "${bookingsController.cancelledBookings.length}",
                              categoryName: "Canceled",
                              height: height,
                              width: width),
                          BookingsInfoContainer(
                              function: () {
                                bookingsController.showInTransitBookings();
                              },
                              number:
                                  "${bookingsController.inTransitBookings.length}",
                              categoryName: "In Transit",
                              height: height,
                              width: width),
                        ],
                      );
                    }),
                    VerticalSpace(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Text(
                            "List of ${bookingsController.selectedCategory.value} bookings",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        }),
                        VerticalSpace(height: 20),
                        Obx(() {
                          return bookingsController.selectedBookings.isNotEmpty
                              ? SizedBox(
                                  width: width * 40,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      // primary: false,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: bookingsController
                                          .selectedBookings.length,
                                      itemBuilder: (context, index) {
                                        return BookingsListTile(
                                            customerName: bookingsController
                                                    .selectedBookings[index]
                                                ['customerName'],
                                            customerDestination:
                                                bookingsController
                                                        .selectedBookings[index]
                                                    ['destination'],
                                            status: bookingsController
                                                    .selectedBookings[index]
                                                ['status'],
                                            docId: bookingsController
                                                    .selectedBookings[index]
                                                ['docId'],
                                            height: height,
                                            width: width);
                                      }),
                                )
                              : Text("No bookings available");
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
