import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghose_travels/src/components/home/drawerComponent.dart';
import 'package:ghose_travels/src/configs/apputils.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/models/vehicles/vehiclesModel.dart';
import 'package:ghose_travels/src/widgets/card/customCardWidget.dart';

import '../../configs/appColors.dart';

class VehiclesListPage extends StatelessWidget with BaseController{
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
                padding:   paddingH10V10,
                child: ListView(
                  children: [

                        FutureBuilder(
                        future: vehiclesC.getAllVehicles(),
                        builder: (context,
                            AsyncSnapshot<List<VehiclesModel>> snapshots) {
                          switch (snapshots.connectionState) {
                            case ConnectionState.none:
                              break;
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            case ConnectionState.active:
                              break;
                            case ConnectionState.done:
                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 2,
                                ),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: snapshots.data!.length,
                                itemBuilder: (c, i) {
                                  final item = snapshots.data![i];
                                  return CustomCardWidget(
                                    color: white,
                                    borderRadius: BorderRadius.circular(5),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            item.carImage.toString(),
                                            width:size.width,
                                            // height: 200,
                                            // fit: BoxFit.cover,
                                          ),
                                        ),
                                        // CachedNetworkImageWidget(
                                        //   imageUrl: item.imageLink,
                                        // ),
                                        Positioned(
                                          right: 10,
                                          top: 0,
                                          child: IconButton(
                                            onPressed: () {},
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
                          }
                          return Container();
                        }),
                    // GridView.builder(
                    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 4,
                    //       mainAxisSpacing: 10,
                    //       crossAxisSpacing: 10,
                    //     ),

                    //     shrinkWrap: true,primary: false,itemCount: 6,
                    //     itemBuilder: (c, i) {
                    //       return CustomCardWidget(
                    //         color: white,
                    //         child: FlutterLogo(),
                    //       );
                    //     }),
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
