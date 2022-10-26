import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/components/home/drawerComponent.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/pages/bookings/widgets/bookings_list_tile.dart';
import 'package:ghose_travels/src/widgets/white_space/vertical_space.dart';

import '../../widgets/kText/kText.dart';
import 'widgets/bookings_info_container.dart';

class BookingsScreen extends StatelessWidget with BaseController {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

    var size = MediaQuery.of(context).size;
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Bookings',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return Scaffold(
      key: _scaffoldKey,
      appBar: size.width < 900
          ? AppBar(
              title: KText(text: 'Bookings'),
            )
          : null,
      drawer: size.width < 900
          ? DrawerComponent().customDrawer(context, width: 300)
          : null,
      body: Row(
        children: [
          size.width < 900
              ? SizedBox()
              : Container(
                  child: DrawerComponent().customDrawer(context),
                ),
          Expanded(
              child: Container(
            height: height * 100,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpace(height: 20),
                  Obx(() {
                    return FittedBox(
                      child: SizedBox(
                        height: 120,
                        child: ListView(
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              children: [
                                BookingsInfoContainer(
                                  function: () {
                                    bookingsController.showAllBookings();
                                  },
                                  number:
                                      "${bookingsController.allBookings.length}",
                                  categoryName: "Total Bookings",
                                  height: height,
                                  width: width,
                                ),
                                BookingsInfoContainer(
                                    function: () {
                                      bookingsController
                                          .showConfirmedBookings();
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
                                    number: bookingsController
                                        .pendingBookings.length
                                        .toString(),
                                    categoryName: "Pending",
                                    height: height,
                                    width: width),
                                BookingsInfoContainer(
                                    function: () {
                                      bookingsController
                                          .showCancelledBookings();
                                    },
                                    number:
                                        "${bookingsController.cancelledBookings.length}",
                                    categoryName: "Canceled",
                                    height: height,
                                    width: width),
                                BookingsInfoContainer(
                                    function: () {
                                      bookingsController
                                          .showInTransitBookings();
                                    },
                                    number:
                                        "${bookingsController.inTransitBookings.length}",
                                    categoryName: "In Transit",
                                    height: height,
                                    width: width),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                                width: size.width/1.1,
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
                                              .selectedBookings[index]['docId'],
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
          )),
        ],
      ),
    );
  }
}
