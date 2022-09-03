// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/components/home/drawerComponent.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/configs/apputils.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/helpers/dividerWithText.dart';
import 'package:ghose_travels/src/widgets/buttons/primaryButton.dart';
import 'package:ghose_travels/src/widgets/formfield/customFormField.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';
import 'package:intl/intl.dart';

import '../../widgets/card/customCardWidget.dart';

class BrandsOfPage extends StatefulWidget {
  @override
  State<BrandsOfPage> createState() => _BrandsOfPageState();
}

class _BrandsOfPageState extends State<BrandsOfPage> with BaseController {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
      label: 'Brands Of',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      backgroundColor: white,
      appBar: size.width < 900
          ? AppBar(
              title: KText(text: 'Add New Brands Of'),
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
                  child: Obx(
                    () => ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: [
                        sizeH40,
                        brandsC.isFormEnable.value == true
                            ? editItem()
                            : getItem(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getItem() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              child: primaryButton(
                buttonName: 'Add',
                onTap: () {
                  setState(() {
                    brandsC.isFormEnable.value = true;

                    brandsC.isAddBrandsOff.value = true;
                    brandsC.brandOfId.value = '';
                    brandsC.brandOfTextC.text = '';
                  });
                },
              ),
            ),
          ],
        ),
        sizeH20,
        dividerWithText(title: 'All Brands Of'),
        sizeH20,
        StreamBuilder(
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
                      height: 100,
                      width: Get.width,
                      color: white,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KText(
                                  text: '${item['brandsOfName']}',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    brandsC.isFormEnable.value = true;

                                    brandsC.isUpdateBrandsOff.value = true;
                                    brandsC.brandOfId.value = item['id'];
                                    brandsC.brandOfTextC.text =
                                        item['brandsOfName'];
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      brandsC.removeBrandsOf(item['id']),
                                  icon: Icon(
                                    Icons.delete,
                                  ),
                                ),
                              ],
                            ),
                            sizeH10,
                            Row(
                              children: [
                                KText(
                                  text: DateFormat.yMMMd()
                                      .format(item['time'].toDate()),
                                  fontSize: 12,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                  color: grey,
                                ),
                                Spacer(),
                                KText(
                                  text: DateFormat.jm().format(
                                    item['time'].toDate(),
                                  ),
                                  fontSize: 12,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                  color: grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ],
    );
  }

  editItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dividerWithText(title: 'Add New Brands Of'),
        sizeH20,
        KText(
          text: 'Brands Of Name',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        sizeH10,
        customFormField(
          controller: brandsC.brandOfTextC,
          isIconHide: true,
          textColor: grey,
          borderRadius: BorderRadius.circular(5),
          hintText: 'Brands Of Name',
        ),
        sizeH20,
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: primaryButton(
                buttonName: 'Back',
                buttonColor: redAccent,
                onTap: () {
                  setState(() {
                    brandsC.isAddBrandsOff.value = false;
                    brandsC.isAddBrandsOff.value = false;
                    brandsC.isFormEnable.value = false;
                  });
                },
              ),
            ),
            sizeW20,
            Expanded(
              child: primaryButton(
                buttonName: brandsC.isAddBrandsOff.value == true
                    ? 'Add'
                    : brandsC.isUpdateBrandsOff.value == true
                        ? 'Update'
                        : '',
                onTap: brandsC.isAddBrandsOff.value == true
                    ? () {
                        print(brandsC.brandOfId);
                        print(brandsC.brandOfTextC.text);
                        brandsC.addNewBrandsOf();
                      }
                    : brandsC.isUpdateBrandsOff.value == true
                        ? () {
                            print(brandsC.brandOfId);
                            print(brandsC.brandOfTextC.text);
                            brandsC.updateBrandsOf();
                          }
                        : () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
