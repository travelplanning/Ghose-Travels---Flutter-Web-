import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';

class BookingsListTile extends StatelessWidget with BaseController {
  BookingsListTile({
    Key? key,
    required this.height,
    required this.width,
    required this.customerName,
    required this.customerDestination,
    required this.status,
    required this.docId,
  }) : super(key: key);

  final double height;
  final double width;
  final String customerName;
  final String customerDestination;
  final String status;
  final String docId;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 10,
      // width: width * ,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: themeColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: ListTile(
          onTap: () {
            bookingsController.getTempDocId(docId);
            // Get.to(() => BookingDetailsScreen());
            Get.toNamed('/booking_details');
          },
          title: Text(customerName),
          subtitle: Text("To : $customerDestination"),
          trailing: SizedBox(
            width: width * 7,
            child: Row(
              children: [
                Text("$status"),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
