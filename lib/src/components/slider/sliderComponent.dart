// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/widgets/card/customCardWidget.dart';

import '../../configs/appColors.dart';

class SliderComponent extends StatelessWidget with BaseController {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: sliderC.getAllSlider(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return CustomCardWidget(
          color: white,
          elevation: .7,
          child: CarouselSlider.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (BuildContext context, int i, int pageViewIndex) {
              var item = snapshot.data!.docs[i].data();
              return Stack(
                children: [
                  Container(
                    height: 200,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),

                      child:Image.network(item.toString()),
                      // child: Image.network(
                      //   item['campaignImage'],
                      // ),
                      // child: CachedNetworkImageWidget(
                      //   isImgCircular: true,
                      //   imageUrl: item.toString(),
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  ),
                ],
              );
            },
            options: CarouselOptions(
              height: 200,
              // aspectRatio: 16 / 9,
              viewportFraction: 1,
              pageSnapping: true,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,

              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              // onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      },
    );
  }
}
