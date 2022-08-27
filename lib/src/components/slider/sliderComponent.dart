// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderComponent extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CarouselSlider.builder(
      itemCount: 2,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        //
       
        return  Stack(
                children: [
                  Container(
                    height: 200,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: FlutterLogo(
                        size: 200,
                      ),
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
    );
  }
}
