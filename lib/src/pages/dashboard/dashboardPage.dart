import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghose_travels/src/components/home/drawerComponent.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/configs/appUtils.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/widgets/card/customCardWidget.dart';
import 'package:ghose_travels/src/widgets/hexColor/hexColor.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';

class DashboardPage extends StatelessWidget with BaseController {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Dashboard',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      backgroundColor: white,
      appBar: size.width < 900
          ? AppBar(
              title: KText(text: 'Dashboard'),
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
            child: SingleChildScrollView(
              child: Container(
                height: size.height,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: size.width < 900
                          ? size.width / 1.1
                          : size.width / 2.5,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              getTotalUser(),
                              getTotalBookings(),
                            ],
                          ),
                          Row(
                            children: [
                              getTotalPendigs(),
                              getTotalTransit(),
                            ],
                          ),
                          Row(
                            children: [
                              totalConfirmed(),
                              totalCancelled(),
                            ],
                          ),
                          Row(
                            children: [
                              totalCar(),
                              totalBrand(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getTotalUser() {
    return StreamBuilder(
        stream: dashboardC.getUsers(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var totalUser = snapshot.data!.size;

          return _menuUi(
            'Total Users',
            '$totalUser',
            HexColor('#7d5fff'),
          );
        });
  }

  getTotalBookings() {
    return StreamBuilder(
        stream: dashboardC.getBookings(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var totalBookings = snapshot.data!.size;

          return _menuUi(
            'Total Bookings',
            '$totalBookings',
            HexColor('#4b4b4b'),
          );
        });
  }

  getTotalPendigs() {
    return StreamBuilder(
        stream: dashboardC.getPendingBookings(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var totalPendings = snapshot.data!.size;

          return _menuUi(
            'Pending',
            '$totalPendings',
            blue50,
          );
        });
  }

  getTotalTransit() {
    return StreamBuilder(
        stream: dashboardC.getTransitBookings(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var totalTransit = snapshot.data!.size;

          return _menuUi(
            'Transit',
            '$totalTransit',
            HexColor('#67e6dc'),
          );
        });
  }

  totalConfirmed() {
    return StreamBuilder(
        stream: dashboardC.getConfirmedBookings(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var totalConfirmed = snapshot.data!.size;

          return _menuUi(
            'Confirmed',
            '$totalConfirmed',
            green,
          );
        });
  }

  totalCancelled() {
    return StreamBuilder(
        stream: dashboardC.getCancelledBookings(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var totalCancelled = snapshot.data!.size;

          return _menuUi(
            'Cancelled',
            '$totalCancelled',
            redAccent,
          );
        });
  }

  totalCar() {
    return StreamBuilder(
        stream: vehiclesC.getAllVehicles(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var totalCar = snapshot.data!.size;

          return _menuUi(
            'Total Car',
            '$totalCar',
            HexColor('#ffa502'),
          );
        });
  }

  totalBrand() {
    return StreamBuilder(
        stream: brandsC.getAllBrands(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var totalBrand = snapshot.data!.size;

          return _menuUi(
            'Total Brand',
            '$totalBrand',
            HexColor('#60a3bc'),
          );
        });
  }

  _menuUi(title, content, Color color) {
    return Expanded(
      child: CustomCardWidget(
        color: color,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KText(
              text: title,
              fontSize: 20,
              color: white,
            ),
            sizeH20,
            KText(
              text: content,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: white,
            ),
          ],
        ),
      ),
    );
  }
}
