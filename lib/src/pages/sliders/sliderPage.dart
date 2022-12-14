// ignore_for_file: deprecated_member_use


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghose_travels/src/components/home/drawerComponent.dart';

import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/configs/appUtils.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/widgets/cachedNetworkImage/image.dart';
import 'package:ghose_travels/src/widgets/card/customCardWidget.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';

class SliderPage extends StatefulWidget {
  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> with BaseController {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

 
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Slider',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      backgroundColor: white,
      appBar: size.width < 900
          ? AppBar(
              title: KText(text: 'Slider'),
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
                child: Padding(
                  padding: paddingH10V10,
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      sizeH40,
                      // Row(
                      //   children: [
                      //     KText(text: 'Preview'),
                      //     sizeW20,
                      //     Expanded(
                      //       child: Container(
                      //         color: grey,
                      //         height: 1,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // sizeH20,
                      // SliderComponent(),
                      // sizeH20,
                      Row(
                        children: [
                          KText(text: 'Add New Slider'),
                          sizeW20,
                          Expanded(
                            child: Container(
                              color: grey,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      sizeH20,
                      InkWell(
                        onTap: () {
                       
                            sliderC.addSliderImage(
                               );
                         
                          // sliderUrl();
                          // pickImageFromGallery();
                        },

                        // onTap: ()=>pickImageFromGallery(),
                        child: Container(
                          height: 200,
                          width: size.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 40,
                            color: grey,
                          ),
                        ),
                      ),
                      sizeH20,
                      Row(
                        children: [
                          KText(text: 'All Slider'),
                          sizeW20,
                          Expanded(
                            child: Container(
                              color: grey,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      sizeH20,
                      StreamBuilder(
                          stream: sliderC.getAllSlider(),
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
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 2,
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
                                        child: imageShow(
                                            items['campaignImage'].toString()),
                                      ),
                                      // ClipRRect(
                                      // borderRadius: BorderRadius.circular(5),
                                      //   child: Image.network(
                                      //     items['campaignImage'].toString(),
                                      //     width: Get.width,
                                      //     height: 200,
                                      //     fit: BoxFit.cover,
                                      //   ),
                                      // ),
                                      // CachedNetworkImageWidget(
                                      //   imageUrl: item.imageLink,
                                      // ),
                                      Positioned(
                                        right: 10,
                                        top: 0,
                                        child: IconButton(
                                          onPressed: () => sliderC
                                              .deleteSlider(id.toString()),
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
                      // FutureBuilder(
                      //     future: sliderC.getAllSlider(),
                      //     builder: (context,
                      //         AsyncSnapshot<List<SliderModel>> snapshots) {
                      //       switch (snapshots.connectionState) {
                      //         case ConnectionState.none:
                      //           break;
                      //         case ConnectionState.waiting:
                      //           return CircularProgressIndicator();
                      //         case ConnectionState.active:
                      //           break;
                      //         case ConnectionState.done:
                      //           return GridView.builder(
                      //             gridDelegate:
                      //                 SliverGridDelegateWithFixedCrossAxisCount(
                      //               crossAxisCount: 3,
                      //               mainAxisSpacing: 10,
                      //               crossAxisSpacing: 10,
                      //               childAspectRatio: 2,
                      //             ),
                      //             shrinkWrap: true,
                      //             primary: false,
                      //             itemCount: snapshots.data!.length,
                      //             itemBuilder: (c, i) {
                      //               final item = snapshots.data![i];
                      //               return CustomCardWidget(
                      //                 color: white,
                      //                 borderRadius: BorderRadius.circular(5),
                      //                 child: Stack(
                      //                   children: [
                      //                     ClipRRect(
                      //                       borderRadius:
                      //                           BorderRadius.circular(5),
                      //                       child: Image.network(
                      //                         item.imageLink.toString(),
                      //                         width: Get.width,
                      //                         height: 200,
                      //                         fit: BoxFit.cover,
                      //                       ),
                      //                     ),
                      //                     // CachedNetworkImageWidget(
                      //                     //   imageUrl: item.imageLink,
                      //                     // ),
                      //                     Positioned(
                      //                       right: 10,
                      //                       top: 0,
                      //                       child: IconButton(
                      //                         onPressed: () =>
                      //                             sliderC.deleteSlider(
                      //                                 item.id.toString()),
                      //                         icon: Icon(
                      //                           Icons.delete,
                      //                           color: redAccent,
                      //                           size: 30,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               );
                      //             },
                      //           );
                      //       }
                      //       return Container();
                      //     }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
