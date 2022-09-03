import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/components/home/drawerComponent.dart';
import 'package:ghose_travels/src/configs/apputils.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/helpers/dividerWithText.dart';
import 'package:ghose_travels/src/widgets/buttons/addFileButton.dart';
import 'package:ghose_travels/src/widgets/buttons/primaryButton.dart';
import 'package:ghose_travels/src/widgets/card/customCardWidget.dart';
import 'package:ghose_travels/src/widgets/card/customGirdCard.dart';
import 'package:ghose_travels/src/widgets/dialog/customPopUpDialog.dart';
import 'package:ghose_travels/src/widgets/formfield/customFormField.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';
import 'package:ghose_travels/src/widgets/snackbar/snackbar.dart';

import '../../configs/appColors.dart';

class VehiclesListPage extends StatefulWidget {
  @override
  State<VehiclesListPage> createState() => _VehiclesListPageState();
}

class _VehiclesListPageState extends State<VehiclesListPage>
    with BaseController {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var carId = '';

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
      appBar: size.width < 900
          ? AppBar(
              title: KText(text: 'Vehicles'),
            )
          : null,
      drawer: size.width < 900
          ? DrawerComponent().customDrawer(context, width: 300)
          : null,
      body: Obx(
        () => Row(
          children: [
            size.width < 900
                ? SizedBox()
                : Container(
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
                            icons: vehiclesC.isAddVehicles.value == true
                                ? Icons.close
                                : Icons.add,
                            buttonColor: vehiclesC.isAddVehicles.value == true
                                ? redAccent
                                : buttonColorBlue,
                            buttonName: vehiclesC.isAddVehicles.value == true
                                ? 'Close'
                                : 'Add New Vehicles',
                            onTap: vehiclesC.isAddVehicles.value == true
                                ? () {
                                    setState(() {
                                      vehiclesC.isAddVehicles.value = false;
                                    });
                                  }
                                : () {
                                    setState(() {
                                      vehiclesC.clear();
                                      vehiclesC.isAddVehicles.value = true;
                                      vehiclesC.isUpdateVehicles.value = false;
                                    });
                                  },
                            width: vehiclesC.isAddVehicles.value == true
                                ? size.width / 5
                                : size.width < 900
                                    ? size.width / 2
                                    : size.width / 5,
                          ),
                          sizeW20,
                          vehiclesC.isAddVehicles.value == true
                              ? primaryButton(
                                  icons: Icons.save,
                                  buttonName: 'Save',
                                  onTap: () {
                                    if (vehiclesC.advancedPayAmountTextC.text
                                            .isNotEmpty &&
                                        vehiclesC
                                            .brandNameTextC.text.isNotEmpty &&
                                        vehiclesC
                                            .carImageTextC.text.isNotEmpty &&
                                        vehiclesC
                                            .carImageTextC.text.isNotEmpty &&
                                        vehiclesC
                                            .carNameTextC.text.isNotEmpty &&
                                        vehiclesC
                                            .carRentTextC.text.isNotEmpty &&
                                        vehiclesC
                                            .modelYearTextC.text.isNotEmpty) {
                                      if (vehiclesC.isUpdateVehicles.value ==
                                          true) {
                                        vehiclesC.updateVehicles(carId);
                                      } else {
                                        vehiclesC.addNewVehicles();
                                      }
                                    } else {
                                      emptySnackBarWidget();
                                    }
                                  },
                                  width: size.width / 5,
                                )
                              : Container(),
                        ],
                      ),
                      sizeH20,
                      dividerWithText(
                          title: vehiclesC.isAddVehicles.value == true
                              ? 'Add New Vehicles'
                              : 'All Vehicles'),
                      sizeH20,
                      vehiclesC.isAddVehicles.value == true
                          ? addVehiclesItem(size)
                          : itemList(size),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addVehiclesItem(Size size) {
    return CustomCardWidget(
      color: white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizeH20,
            KText(
              text: 'Add Image',
              fontWeight: FontWeight.bold,
            ),
            sizeH10,
            addFileButton(
              context,
              icon: vehiclesC.carImageTextC.text == ''
                  ? null
                  : Image.network(
                      vehiclesC.carImageTextC.text,
                      width: size.width,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
              onTap: () => imageUrl(),
            ),
            sizeH20,
            KText(
              text: 'Brand Name',
              fontWeight: FontWeight.bold,
            ),
            sizeH10,
            customFormField(
              controller: vehiclesC.brandNameTextC,
              borderRadius: BorderRadius.circular(5),
              readOnly: true,
              isIconHide: true,
              hintText: 'Select Brand Name',
              suffixIcon: IconButton(
                onPressed: () => brandSelect(),
                icon: Icon(Icons.arrow_drop_down),
              ),
              textColor: black54,
            ),
            sizeH20,
            KText(
              text: 'Car Name',
              fontWeight: FontWeight.bold,
            ),
            sizeH10,
            customFormField(
              controller: vehiclesC.carNameTextC,
              borderRadius: BorderRadius.circular(5),
              isIconHide: true,
              hintText: 'Car Name',
              textColor: black54,
            ),
            sizeH20,
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Car Model',
                        fontWeight: FontWeight.bold,
                      ),
                      sizeH10,
                      customFormField(
                        controller: vehiclesC.modelYearTextC,
                        borderRadius: BorderRadius.circular(5),
                        isIconHide: true,
                        hintText: 'Car Model',
                        textColor: black54,
                      ),
                    ],
                  ),
                ),
                sizeW20,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Car Rent',
                        fontWeight: FontWeight.bold,
                      ),
                      sizeH10,
                      customFormField(
                        controller: vehiclesC.carRentTextC,
                        borderRadius: BorderRadius.circular(5),
                        isIconHide: true,
                        hintText: 'Car Rent',
                        textColor: black54,
                      ),
                    ],
                  ),
                ),
                size.width < 900 ? Container() : sizeW20,
                size.width < 900
                    ? Container()
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Advanced Pay Amount',
                              fontWeight: FontWeight.bold,
                            ),
                            sizeH10,
                            customFormField(
                              controller: vehiclesC.advancedPayAmountTextC,
                              borderRadius: BorderRadius.circular(5),
                              isIconHide: true,
                              hintText: 'Advanced Pay Amount',
                              textColor: black54,
                            ),
                          ],
                        ),
                      ),
              ],
            ),
            size.width < 900 ? sizeH20 : sizeW20,
            size.width < 900
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Advanced Pay Amount',
                        fontWeight: FontWeight.bold,
                      ),
                      sizeH10,
                      customFormField(
                        controller: vehiclesC.advancedPayAmountTextC,
                        borderRadius: BorderRadius.circular(5),
                        isIconHide: true,
                        hintText: 'Advanced Pay Amount',
                        textColor: black54,
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  itemList(Size size) {
    return StreamBuilder(
        stream: vehiclesC.getAllVehicles(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: size.width < 900 ? 2 : 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: size.width < 900 ? .7 : 1.3,
            ),
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              final items = snapshot.data!.docs[index].data();
              final id = snapshot.data!.docs[index].id;

              return CustomGridCard(
                onTap: (){},
                editOnTap: () {
                              setState(() {
                                carId = items['carId'];
                                vehiclesC.carNameTextC.text = items['carName'];
                                vehiclesC.carImageTextC.text =
                                    items['carImage'];
                                vehiclesC.brandNameTextC.text =
                                    items['brandName'];
                                vehiclesC.carRentTextC.text =
                                    items['carRent'].toString();
                                vehiclesC.modelYearTextC.text =
                                    items['modelYear'].toString();
                                vehiclesC.advancedPayAmountTextC.text =
                                    items['advancedPaymentAmount'].toString();
                                vehiclesC.brandId.value = items['brandId'];
                                vehiclesC.isAddVehicles.value = true;
                                vehiclesC.isUpdateVehicles.value = true;
                              });
                            },
                deleteOnTap:  () => vehiclesC.removeVehicles(id.toString()),
                title1: items['carName'],
                title2: items['modelYear'],
                dateTime: items['time'],
                image:  items['carImage'],
              );

              // CustomCardWidget(
              //   color: white,
              //   borderRadius: BorderRadius.circular(5),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Stack(
              //         children: [
              //           ClipRRect(
              //             borderRadius: BorderRadius.circular(5),
              //             child: Image.network(
              //               items['carImage'].toString(),
              //               width: size.width,
              //               height: 200,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           // CachedNetworkImageWidget(
              //           //   imageUrl: item.imageLink,
              //           // ),

              //           Positioned(
              //             left: 10,
              //             top: 0,
              //             child: IconButton(
                            // onPressed: () {
                            //   setState(() {
                            //     carId = items['carId'];
                            //     vehiclesC.carNameTextC.text = items['carName'];
                            //     vehiclesC.carImageTextC.text =
                            //         items['carImage'];
                            //     vehiclesC.brandNameTextC.text =
                            //         items['brandName'];
                            //     vehiclesC.carRentTextC.text =
                            //         items['carRent'].toString();
                            //     vehiclesC.modelYearTextC.text =
                            //         items['modelYear'].toString();
                            //     vehiclesC.advancedPayAmountTextC.text =
                            //         items['advancedPaymentAmount'].toString();
                            //     vehiclesC.brandId.value = items['brandId'];
                            //     vehiclesC.isAddVehicles.value = true;
                            //     vehiclesC.isUpdateVehicles.value = true;
                            //   });
                            // },
              //               icon: Icon(
              //                 Icons.edit,
              //                 color: buttonColorBlue,
              //                 size: 30,
              //               ),
              //             ),
              //           ),
              //           Positioned(
              //             right: 10,
              //             top: 0,
              //             child: IconButton(
                            // onPressed: () =>
                            //     vehiclesC.removeVehicles(id.toString()),
              //               icon: Icon(
              //                 Icons.delete,
              //                 color: redAccent,
              //                 size: 30,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       sizeH10,
              //       Padding(
              //         padding: paddingH10,
              //         child: KText(
              //           text: '${items['carName']} (${items['modelYear']})',
              //           fontSize: 18,
              //           maxLines: 1,
              //           overflow: TextOverflow.ellipsis,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       sizeH10,
              //       Padding(
              //         padding: paddingH10,
              //         child: Row(
              //           children: [
              //             KText(
              //               text: DateFormat.yMMMd()
              //                   .format(items['time'].toDate()),
              //               fontSize: 14,
              //               maxLines: 1,
              //               overflow: TextOverflow.ellipsis,
              //               fontWeight: FontWeight.w600,
              //             ),
              //             Spacer(),
              //             KText(
              //               text: DateFormat.jm().format(
              //                 items['time'].toDate(),
              //               ),
              //               fontSize: 14,
              //               maxLines: 1,
              //               overflow: TextOverflow.ellipsis,
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            },
          );
        });
  }

  Future<void> brandSelect() async {
    return customDialogWidget(
      context,
      headerTitle: 'Brand List',
      child: StreamBuilder(
          stream: brandsC.getAllBrands(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: snapshot.data!.size,
                itemBuilder: (c, i) {
                  var item = snapshot.data!.docs[i].data();

                  return CustomCardWidget(
                    onTap: () {
                      setState(() {
                        vehiclesC.brandId.value = item['id'];
                        vehiclesC.brandNameTextC.text = item['name'];
                        Get.back();
                      });
                    },
                    height: 60,
                    width: Get.width,
                    color: white,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            item['image'],
                            width: 100,
                          ),
                          sizeW20,
                          KText(
                            text: '${item['name']}',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          Spacer(),
                          vehiclesC.brandId.value == item['id']
                              ? CircleAvatar(
                                  radius: 12,
                                  child: Icon(
                                    Icons.done,
                                    size: 20,
                                    color: white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }

  Future<void> imageUrl() async {
    return customDialogWidget(
      context,
      headerTitle: 'Car Image',
      child: TextFormField(
        controller: vehiclesC.carImageTextC,
        onChanged: (val) {
          setState(() {
            vehiclesC.carImageTextC.text = val;
          });
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: black,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: black,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: KText(text: 'Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: KText(text: 'Add'),
          onPressed: () {
            setState(() {
              vehiclesC.carImageTextC.text = vehiclesC.carImageTextC.text;
            });

            Get.back();
          },
        ),
      ],
    );
  }
}
