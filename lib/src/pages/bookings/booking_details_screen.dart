import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/components/home/drawerComponent.dart';
import 'package:ghose_travels/src/components/round_button_widget.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/service/bookings/change_booking_status_service.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';
import 'package:ghose_travels/src/widgets/white_space/horizontal_space.dart';
import 'package:ghose_travels/src/widgets/white_space/vertical_space.dart';

class BookingDetailsScreen extends StatelessWidget with BaseController {
  BookingDetailsScreen({
    Key? key,
  }) : super(key: key);
  // final String docId;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: size.width < 900
          ? AppBar(
              title: KText(text: 'Bokking Details'),
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
          // HorizontalSpace(width: width * 5),
          Obx(() {
            // log("this is doc id ${bookingsController.tempDocId.value}");
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                ),
                SizedBox(
                  width: width * 40,
                  child: FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('bookings')
                          .doc(bookingsController.tempDocId.value)
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: themeColor,
                          ));
                        }
                        if (!snapshot.data!.exists) {
                          return const Text("Bookig details not found.");
                        }
                        var data = snapshot.data;
                        Timestamp timestamp = data!['bookingDate'];
                        DateTime dateTime = timestamp.toDate();
                        return ListView(
                          children: [
                            VerticalSpace(height: 20),
                            Container(
                                margin: const EdgeInsets.all(10),
                                height: height * 15,
                                decoration: BoxDecoration(
                                    color: themeColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: ListTile(
                                    title: Text(
                                      snapshot.data!['vehicleName'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                        "Booking date ${dateTime.day}/${dateTime.month}/${dateTime.year}"),
                                    trailing: Text(data['status']),
                                    // trailing: Image(image: NetworkImage(carPhoto)),
                                  ),
                                )),
                            const VerticalSpace(height: 10),
                            ListTile(
                              title: Text("Car Model : ${data['vehicleName']}"),
                              leading: const Icon(Icons.car_rental),
                              minLeadingWidth: 0,
                            ),
                            Divider(
                                color: themeColor, endIndent: 10, indent: 10),
                            ListTile(
                              title: Text(
                                  "Booking date : ${dateTime.day}/${dateTime.month}/${dateTime.year}"),
                              leading: const Icon(Icons.abc),
                              minLeadingWidth: 0,
                            ),
                            Divider(
                                color: themeColor, endIndent: 10, indent: 10),
                            ListTile(
                              title:
                                  Text("Destination : ${data['destination']}"),
                              leading: const Icon(Icons.location_history),
                              minLeadingWidth: 0,
                            ),
                            Divider(
                                color: themeColor, endIndent: 10, indent: 10),
                            ListTile(
                              title: Text("Pick up : ${data['pickUpAddress']}"),
                              leading: const Icon(Icons.location_city),
                              minLeadingWidth: 0,
                            ),
                            Divider(
                                color: themeColor, endIndent: 10, indent: 10),
                            ListTile(
                              title: Text("Mobile : ${data['customerPhone']}"),
                              leading: const Icon(Icons.phone),
                              minLeadingWidth: 0,
                            ),
                            Divider(
                                color: themeColor, endIndent: 10, indent: 10),
                            ListTile(
                              title: Text("Email : ${data['customerEmail']}"),
                              leading: const Icon(Icons.mail),
                              minLeadingWidth: 0,
                            ),
                          ],
                        );
                      }),
                ),
                HorizontalSpace(width: width * 5),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('bookings')
                        .doc(bookingsController.tempDocId.value)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: themeColor,
                        ));
                      }
                      if (!snapshot.data!.exists) {
                        return const Text("Booking details not found.");
                      }
                      var data = snapshot.data;
                      return Container(
                          height: height * 45,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: themeColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Status : " +
                                    "${data!['status']}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              VerticalSpace(height: 15),
                              Text("Change this order\'s status -"),
                              VerticalSpace(height: 15),
                              SizedBox(
                                width: width * 15,
                                height: height * 5,
                                child: RoundButtonWidget(
                                    labelText: "Confirm",
                                    backgroundColor:
                                        Color.fromARGB(255, 98, 155, 101),
                                    icon: Icons.verified_outlined,
                                    function: () {
                                      ChangeBookingStatusService()
                                          .updateBookingStatus(
                                              status: "confirmed");
                                    }),
                              ),
                              VerticalSpace(height: 10),
                              SizedBox(
                                width: width * 15,
                                height: height * 5,
                                child: RoundButtonWidget(
                                    labelText: "Pending",
                                    backgroundColor:
                                        themeColor.withOpacity(0.8),
                                    icon: Icons.pending,
                                    function: () {
                                      ChangeBookingStatusService()
                                          .updateBookingStatus(
                                              status: "pending");
                                    }),
                              ),
                              VerticalSpace(height: 10),
                              SizedBox(
                                width: width * 15,
                                height: height * 5,
                                child: RoundButtonWidget(
                                    labelText: "In Transit",
                                    backgroundColor:
                                        Color.fromARGB(255, 127, 156, 206),
                                    icon: Icons.car_rental,
                                    function: () {
                                      ChangeBookingStatusService()
                                          .updateBookingStatus(
                                              status: "inTransit");
                                    }),
                              ),
                              VerticalSpace(height: 10),
                              SizedBox(
                                width: width * 15,
                                height: height * 5,
                                child: RoundButtonWidget(
                                    labelText: "Cancel",
                                    backgroundColor:
                                        Color.fromARGB(255, 211, 88, 88),
                                    icon: Icons.cancel,
                                    function: () {
                                      ChangeBookingStatusService()
                                          .updateBookingStatus(
                                              status: "cancelled");
                                    }),
                              ),
                            ],
                          ));
                    }),
              ],
            );
          }),
        ],
      ),
    );
  }
}
