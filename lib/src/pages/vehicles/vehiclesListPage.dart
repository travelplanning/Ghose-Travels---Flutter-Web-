import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghose_travels/src/components/home/drawerComponent.dart';
import 'package:ghose_travels/src/configs/apputils.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/helpers/dividerWithText.dart';
import 'package:ghose_travels/src/widgets/buttons/primaryButton.dart';
import 'package:ghose_travels/src/widgets/card/customCardWidget.dart';

import '../../configs/appColors.dart';

class VehiclesListPage extends StatelessWidget with BaseController {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Vehicles',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      backgroundColor: white,
      body: Row(
        children: [
          Container(
            child: DrawerComponent().customDrawer(context),
          ),
          Expanded(
            child: Container(
              height: size.height,
              child: Padding(
                padding: paddingH10V10,
                child: ListView(
                  children: [
                    sizeH20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        primaryButton(
                          icons: Icons.add,
                          buttonName: 'Add New Vehicles',
                          onTap: () {},
                          width: size.width / 5,
                        ),
                      ],
                    ),
                    sizeH20,
                    dividerWithText(title: 'All Vehicles'),
                    sizeH20,
                    StreamBuilder(
                        stream: vehiclesC.getAllVehicles(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.size,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) {
                              final items = snapshot.data!.docs[index].data();
                              final id = snapshot.data!.docs[index].id;

                              return CustomCardWidget(
                                color: white,
                                borderRadius: BorderRadius.circular(5),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        items['carImage'].toString(),
                                        width: size.width,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // CachedNetworkImageWidget(
                                    //   imageUrl: item.imageLink,
                                    // ),
                                    Positioned(
                                      left: 10,
                                      top: 0,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          color: buttonColorBlue,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 0,
                                      child: IconButton(
                                        onPressed: () =>
                                            sliderC.deleteSlider(id.toString()),
                                        icon: Icon(
                                          Icons.delete,
                                          color: redAccent,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
