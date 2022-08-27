// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
 

class CachedNetworkImageWidget extends StatelessWidget {
  String? imageUrl;

  double? height;
  double? width;
  BoxFit? fit;
  bool? isImgCircular;

  CachedNetworkImageWidget({
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.isImgCircular,
  });
  @override
  Widget build(BuildContext context) {
     
    return   ClipRRect(
            borderRadius: isImgCircular == true
                ? BorderRadius.circular(10)
                : BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl:   imageUrl.toString(),
              height: height == null ? 50 : height,
              width: width == null ? 50 : width,
              fit: fit,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
  }
}
