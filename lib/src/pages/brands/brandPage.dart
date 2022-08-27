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
import 'package:ghose_travels/src/widgets/formfield/customFormField.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';

import '../../configs/appColors.dart';

class BrandPage extends StatefulWidget {
  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> with BaseController {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var isAddBrands = false;

  Future<void> imageUrl() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: KText(text: 'Brand Image Url'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                  controller: vehiclesC.carImageTextC,
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
              ],
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Brands',
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
      body: Row(
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
                          icons: isAddBrands == true ? Icons.close : Icons.add,
                          buttonColor:
                              isAddBrands == true ? redAccent : buttonColorBlue,
                          buttonName:
                              isAddBrands == true ? 'Close' : 'Add New Brands',
                          onTap: isAddBrands == true
                              ? () {
                                  setState(() {
                                    isAddBrands = false;
                                  });
                                }
                              : () {
                                  setState(() {
                                    isAddBrands = true;
                                  });
                                },
                          width: isAddBrands == true
                              ? size.width / 5
                              : size.width < 900
                                  ? size.width / 2
                                  : size.width / 5,
                        ),
                        sizeW20,
                        isAddBrands == true
                            ? primaryButton(
                                icons: Icons.save,
                                buttonName: 'Save',
                                onTap: () => vehiclesC.addNewVehicles(
                                  brandId: '9LTpmgrVcBCLneHI0YMY',
                                ),
                                width: size.width / 5,
                              )
                            : Container(),
                      ],
                    ),
                    sizeH20,
                    dividerWithText(
                        title: isAddBrands == true
                            ? 'Add New Brands'
                            : 'All Brands'),
                    sizeH20,
                    isAddBrands == true ? addBrandsItem(size) : itemList(size),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addBrandsItem(Size size) {
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
              onTap: () => imageUrl(),
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
        stream: brandsC.getAllBrands(),
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

              return CustomCardWidget(
                color: white,
                borderRadius: BorderRadius.circular(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            items['image'].toString(),
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
                                vehiclesC.removeVehicles(id.toString()),
                            icon: Icon(
                              Icons.delete,
                              color: redAccent,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    sizeH10,
                    Padding(
                      padding: paddingH10,
                      child: KText(
                        text: items['name'] +
                            ' (' +
                            items['brandOf'].toString() +
                            ')',
                        fontSize: 18,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
