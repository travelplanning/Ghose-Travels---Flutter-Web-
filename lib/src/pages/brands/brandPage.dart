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
import 'package:intl/intl.dart';
import '../../configs/appColors.dart';

class BrandPage extends StatefulWidget {
  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> with BaseController {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var carId = '';
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      brandsC.clear();
    });

    super.initState();
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
                            icons: brandsC.isAddBrands.value == true
                                ? Icons.close
                                : Icons.add,
                            buttonColor: brandsC.isAddBrands.value == true
                                ? redAccent
                                : buttonColorBlue,
                            buttonName: brandsC.isAddBrands.value == true
                                ? 'Close'
                                : 'Add New Brands',
                            onTap: brandsC.isAddBrands.value == true
                                ? () {
                                    setState(() {
                                      brandsC.isAddBrands.value = false;
                                    });
                                  }
                                : () {
                                    setState(() {
                                      brandsC.clear();
                                      brandsC.isAddBrands.value = true;
                                      brandsC.isAUpdateBrands.value = false;
                                      brandsC.isVehicleEmpty.value = true;
                                    });
                                  },
                            width: brandsC.isAddBrands.value == true
                                ? size.width / 5
                                : size.width < 900
                                    ? size.width / 2
                                    : size.width / 5,
                          ),
                          sizeW20,
                          brandsC.isAddBrands.value == true
                              ? primaryButton(
                                  icons: Icons.save,
                                  buttonName: 'Save',
                                  onTap: vehiclesC.isUpdateVehicles.value ==
                                          true
                                      ? () {
                                          vehiclesC.updateVehicles(carId);
                                        }
                                      : () {
                                          if (brandsC.brandImageTextC.text
                                                  .isNotEmpty &&
                                              brandsC.brandNameTextC.text
                                                  .isNotEmpty &&
                                              brandsC.brandOfId.value != '') {
                                            if (brandsC.isAUpdateBrands.value ==
                                                true) {
                                              brandsC.updateBrand(
                                                  brandsC.brandId.value);
                                            } else {
                                              print(
                                                  brandsC.brandImageTextC.text);
                                              print(
                                                  brandsC.brandNameTextC.text);
                                              print(brandsC.brandOfTextC.value);
                                              print(brandsC.brandOfId.value);
                                              brandsC.addNewBrand();
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
                      brandsC.isVehicleEmpty.value == false
                          ? Container()
                          : dividerWithText(
                              title: brandsC.isAddBrands.value == true
                                  ? 'Add New Brands'
                                  : 'All Brands'),
                      brandsC.isVehicleEmpty.value == true
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      brandsC.isVehicleEmpty.value = true;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                  ),
                                ),
                                Expanded(
                                  child: Obx(
                                    () => dividerWithText(
                                        title:
                                            '${brandsC.brandName.value} - by vehicles'),
                                  ),
                                )
                              ],
                            ),
                      sizeH20,
                      Obx(
                        () => vehiclesC.isUpdateVehicles.value == true
                            ? updateVehicles(size)
                            : brandsC.isVehicleEmpty.value == false
                                ? brandVehicleList(size)
                                : brandsC.isAddBrands.value == true
                                    ? addBrandsItem(size)
                                    : itemList(size),
                      ),
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
              icon: brandsC.brandImageTextC.text.isNotEmpty
                  ? Image.network(brandsC.brandImageTextC.text)
                  : null,
              onTap: () => imageUrl(),
            ),
            sizeH20,
            KText(
              text: 'Brand Name',
              fontWeight: FontWeight.bold,
            ),
            sizeH10,
            customFormField(
              controller: brandsC.brandNameTextC,
              borderRadius: BorderRadius.circular(5),
              isIconHide: true,
              hintText: 'Brand Name',
              textColor: black54,
            ),
            sizeH20,
            KText(
              text: 'Brand Of Name',
              fontWeight: FontWeight.bold,
            ),
            sizeH10,
            customFormField(
              controller: brandsC.brandOfTextC,
              borderRadius: BorderRadius.circular(5),
              readOnly: true,
              isIconHide: true,
              hintText: 'Select Brand Of Name',
              suffixIcon: IconButton(
                onPressed: () => brandOfSelect(),
                icon: Icon(Icons.arrow_drop_down),
              ),
              textColor: black54,
            ),
            sizeH20,
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

              return CustomGridCard(
                isMoreOption: Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
                onTap: () {
                  setState(() {
                    brandsC.isVehicleEmpty.value = false;
                    brandsC.brandId.value = items['id'];
                    brandsC.brandName.value = items['name'];

                    brandsC.getSingleBrandVehicles();
                  });
                },
                editOnTap: () {
                  setState(() {
                    brandsC.brandId.value = items['id'];
                    brandsC.brandImageTextC.text = items['image'];
                    brandsC.brandNameTextC.text = items['name'];
                    brandsC.brandOfTextC.text = items['brandOf'];
                    brandsC.brandOfId.value = items['brandOfId'];
                    brandsC.isAddBrands.value = true;
                    brandsC.isAUpdateBrands.value = true;
                  });
                },
                deleteOnTap: () => brandsC.removeBrands(id.toString()),
                title1: items['name'],
                title2: items['brandOf'],
                dateTime: items['time'],
                image: items['image'],
              );
            },
          );
        });
  }

  brandVehicleList(Size size) {
    return StreamBuilder(
        stream: brandsC.getSingleBrandVehicles(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.data!.size.isLowerThan(1)
              ? Center(child: KText(text: 'No Data Found!!'))
              : GridView.builder(
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
                                  onPressed: () {
                                    setState(() {
                                      carId = items['carId'];
                                      vehiclesC.carNameTextC.text =
                                          items['carName'];
                                      vehiclesC.carImageTextC.text =
                                          items['carImage'];
                                      vehiclesC.brandNameTextC.text =
                                          items['brandName'];
                                      vehiclesC.carRentTextC.text =
                                          items['carRent'].toString();
                                      vehiclesC.modelYearTextC.text =
                                          items['modelYear'].toString();
                                      vehiclesC.advancedPayAmountTextC.text =
                                          items['advancedPaymentAmount']
                                              .toString();
                                      vehiclesC.brandId.value =
                                          items['brandId'];
                                      vehiclesC.isUpdateVehicles.value = true;
                                      brandsC.isAddBrands.value = true;
                                      brandsC.isAUpdateBrands.value = true;
                                    });
                                  },
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
                              text:
                                  '${items['carName']} (${items['modelYear']})',
                              fontSize: 18,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          sizeH10,
                          Padding(
                            padding: paddingH10,
                            child: Row(
                              children: [
                                KText(
                                  text: DateFormat.yMMMd()
                                      .format(items['time'].toDate()),
                                  fontSize: 14,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                ),
                                Spacer(),
                                KText(
                                  text: DateFormat.jm().format(
                                    items['time'].toDate(),
                                  ),
                                  fontSize: 14,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        });
  }

  updateVehicles(Size size) {
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
      headerTitle: 'Add Image Url',
      child: AlertDialog(
        title: KText(text: 'Brand Image Url'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              TextFormField(
                controller: brandsC.brandImageTextC,
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
                brandsC.brandImageTextC.text = brandsC.brandImageTextC.text;
              });

              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Future<void> brandOfSelect() async {
    return customDialogWidget(
      context,
      headerTitle: 'Brand Of List',
      child: StreamBuilder(
          stream: brandsC.getAllBrandsOf(),
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
                        brandsC.brandOfId.value = item['id'];
                        brandsC.brandOfTextC.text = item['brandsOfName'];
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
                          KText(
                            text: '${item['brandsOfName']}',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          Spacer(),
                          brandsC.brandOfId.value == item['id']
                              ? CircleAvatar(
                                  radius: 12,
                                  backgroundColor: green,
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
      actions: [
        TextButton.icon(
          style: TextButton.styleFrom(
            backgroundColor: buttonColorBlue,
          ),
          onPressed: () {
            Get.toNamed('/brandsOf');
            // setState(() {
            //   brandsC.isAddBrandsOff.value = true;
            // });
          },
          icon: Icon(
            Icons.add,
            color: white,
          ),
          label: KText(
            text: 'Add New Brand Of',
            fontSize: 14,
            color: white,
          ),
        ),
      ],
    );
  }
}
