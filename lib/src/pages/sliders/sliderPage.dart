// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/components/home/drawerComponent.dart';
import 'package:ghose_travels/src/components/slider/sliderComponent.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/configs/appUtils.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/models/sliders/sliderModel.dart';
import 'package:ghose_travels/src/widgets/cachedNetworkImage/cachedNetworkImage.dart';
import 'package:ghose_travels/src/widgets/card/customCardWidget.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';
import 'package:image_picker/image_picker.dart';

class SliderPage extends StatefulWidget {
  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> with BaseController {
  var selectedImage;

  // File? image;
  final pickImage = ImagePicker();
  var isUploading = false;

  Future pickImageFromGallery() async {
    PickedFile? pickedFile =
        await pickImage.getImage(source: ImageSource.gallery);
    setState(() {
      isUploading = true;
    });
    File imageFile = File(pickedFile!.path);

    if (imageFile.path.isNotEmpty) {
      selectedImage = imageFile;
      Get.back();
    }

    setState(() {
      isUploading = false;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> sliderUrl() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: KText(text: 'Slider Image Url'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                  controller: sliderC.sliderUrl,
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
                sliderC.addNewSlider(
                  sliderImage: sliderC.sliderUrl.text,
                );
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
      label: 'Slider',
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
                      Row(
                        children: [
                          KText(text: 'Preview'),
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
                      SliderComponent(),
                      sizeH20,
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
                      GestureDetector(
                        onTap: () {
        sliderC.sliderUrl.clear();

                          sliderUrl();
                        },
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
                      FutureBuilder(
                          future: sliderC.getAllSlider(),
                          builder: (context,
                              AsyncSnapshot<List<SliderModel>> snapshots) {
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
                                              item.imageLink.toString(),
                                              width: Get.width,
                                              height: 200,
                                              fit: BoxFit.cover,
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
